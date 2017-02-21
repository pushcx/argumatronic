--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Control.Applicative ((<$>), Alternative (..))
import Data.Maybe          (fromMaybe)
import Data.Monoid         ((<>))
import Data.List           (isPrefixOf, isSuffixOf, sortBy, intercalate)
import Data.Time.Format    (parseTimeM, defaultTimeLocale)
import Data.Time.Clock     (UTCTime)
import System.FilePath     (takeFileName)

import Text.Pandoc.Options ( WriterOptions
                           , writerHTMLMathMethod
                           , HTMLMathMethod(MathJax)
                           , writerHtml5
                           )
import Hakyll
--------------------------------------------------------------------------------
config :: Configuration
config = defaultConfiguration
         { deployCommand = "rsync -avz -e 'ssh -i ~/.ssh/freya.pem' ./_site/ ubuntu@argumatronic.com:/var/www/argumatronic/" }
-- deployCommand = "./bin/deploy.sh" -- this would be better ?

feedConfig :: FeedConfiguration
feedConfig = FeedConfiguration
     { feedTitle       = "argumatronic"
     , feedDescription = "FP/Haskell blog"
     , feedAuthorName  = "Julie Moronuki"
     , feedAuthorEmail = "srs_haskell_cat@aol.com"
     , feedRoot        = "http://argumatronic.com/"
     }

--------------------------------------------------------------------------------

staticContent :: Pattern
staticContent = "favicon.ico"
           .||. "404.html"
           .||. "images/**"
           .||. "*.txt"
           .||. "presentations/*"
           .||. "publications/*"
           .||. "posts/*"
           .||. "*.pdf"
           .||. "fonts/*"


-- | "Lift" a compiler into an idRoute compiler.
-- idR :: ... => Compiler (Item String) -> Rules ()
idR compiler = do
    route idRoute
    compile pandocCompiler


postsGlob = "posts/*.mdown"

main :: IO ()
main = hakyllWith config $ do
    match staticContent $ idR copyFileCompiler

    match postsGlob $ do
        route $ setExtension "html"
        compile $ copyFileCompiler

    match "*.mdown" $ do
        route $ setExtension "html"
        compile defaultCompiler

    create ["blog.html"] $ idR $ postsCompiler

    create ["rss.xml"] $ idR $ feedCompiler

   -- create ["atom-all.xml"] $ idR $ largeFeedCompiler

    match "templates/*" $ compile templateCompiler

    match "css/*" $ compile cssTemplateCompiler

    match (fromList ["about.md", "contact.markdown", "noobs.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

-------------------------------------------------------------------------------

-- | "Lifts" a template name and a context into a compiler.
defaultTemplateWith :: Identifier -> Context String -> Compiler (Item String)
defaultTemplateWith template ctx =
    makeItem ""
        >>= loadAndApplyTemplate template ctx
        >>= loadAndApplyTemplate "templates/default.html" ctx
        >>= relativizeUrls

cssTemplateCompiler :: Compiler (Item Template)
cssTemplateCompiler = cached "Hakyll.Web.Template.cssTemplateCompiler" $
    fmap (readTemplate . compressCss) <$> getResourceString

postsCompiler :: Compiler (Item String)
postsCompiler = do
    posts <- recentFirst =<< loadAll postsGlob
    defaultTemplateWith "templates/default.html" $ postsCtx posts


postCompiler :: Compiler (Item String)
postCompiler =
    pandocCompilerWith defaultHakyllReaderOptions writerOptions
        >>= saveSnapshot "content"
        >>= loadAndApplyTemplate "templates/post.html"    postCtx
        >>= loadAndApplyTemplate "templates/default.html" postCtx
        >>= relativizeUrls

defaultCompiler :: Compiler (Item String)
defaultCompiler =
    pandocCompilerWith defaultHakyllReaderOptions writerOptions
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

feedCompilerHelper :: (Compiler [Item String] -> Compiler [Item String]) -> Compiler (Item String)
feedCompilerHelper f = do
    posts <- f . recentFirst =<< 
        loadAllSnapshots postsGlob "content"
    renderAtom feedConfig feedCtx posts


feedCompiler :: Compiler (Item String)
feedCompiler = feedCompilerHelper $ fmap (take 10)


largeFeedCompiler :: Compiler (Item String)
largeFeedCompiler = feedCompilerHelper id


feedCtx :: Context String
feedCtx = bodyField "description" <> postCtx


postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    field "nextPost" nextPostUrl <>
    field "prevPost" prevPostUrl <>
    defaultContext

--------------------------------------------------------------------------------
-- Next and previous posts:
-- https://github.com/rgoulter/my-hakyll-blog/commit/a4dd0513553a77f3b819a392078e59f461d884f9

prevPostUrl :: Item String -> Compiler String
prevPostUrl post = do
  posts <- getMatches postsGlob
  let ident = itemIdentifier post
      sortedPosts = sortIdentifiersByDate posts
      ident' = itemBefore sortedPosts ident
  case ident' of
    Just i -> (fmap (maybe empty toUrl) . getRoute) i
    Nothing -> empty


nextPostUrl :: Item String -> Compiler String
nextPostUrl post = do
  posts <- getMatches postsGlob
  let ident = itemIdentifier post
      sortedPosts = sortIdentifiersByDate posts
      ident' = itemAfter sortedPosts ident
  case ident' of
    Just i -> (fmap (maybe empty toUrl) . getRoute) i
    Nothing -> empty


itemAfter :: Eq a => [a] -> a -> Maybe a
itemAfter xs x =
  lookup x $ zip xs (tail xs)


itemBefore :: Eq a => [a] -> a -> Maybe a
itemBefore xs x =
  lookup x $ zip (tail xs) xs


urlOfPost :: Item String -> Compiler String
urlOfPost =
  fmap (maybe empty toUrl) . getRoute . itemIdentifier

sortIdentifiersByDate :: [Identifier] -> [Identifier]
sortIdentifiersByDate =
    sortBy byDate
  where
    byDate id1 id2 =
      let fn1 = takeFileName $ toFilePath id1
          fn2 = takeFileName $ toFilePath id2
          parseTime' fn = parseTimeM True defaultTimeLocale "%Y-%m-%d" $ intercalate "-" $ take 3 $ splitAll "-" fn
      in compare (parseTime' fn1 :: Maybe UTCTime) (parseTime' fn2 :: Maybe UTCTime)
--------------------------------------------------------------------------------

postsCtx :: [Item String] -> Context String
postsCtx posts =
    listField "posts" postCtx (return posts) <>
    constField "description" "Writings"      <>
    constField "title" "Blog"                <>
    defaultContext

homeCtx :: Context String
homeCtx =
    constField "description" "Writings"     <>
    constField "title" "Home"               <>
    defaultContext


writerOptions :: WriterOptions
writerOptions = defaultHakyllWriterOptions
    { writerHTMLMathMethod = MathJax "http://cdn.mathjax.org/mathjax/latest/MathJax.js"
    , writerHtml5          = True
    }


-- main :: IO ()
-- main = hakyllWith config $ do
--    match "images/*" $ do
--         route   idRoute
--         compile copyFileCompiler
--    match "favicon.ico" $ do
--         route   idRoute
--         compile copyFileCompiler
--    match "css/*" $ do
--         route   idRoute
--         compile compressCssCompiler
--    match "fonts/*" $ do
--         route   idRoute
--         compile copyFileCompiler
--    match (fromList ["about.md", "contact.markdown", "noobs.markdown"]) $ do
--         route   $ setExtension "html"
--         compile $ pandocCompiler
--             >>= loadAndApplyTemplate "templates/default.html" defaultContext
--             >>= relativizeUrls
--    tags <- buildTags "posts/*" (fromCapture "tags/*.html")
--    tagsRules tags $ \tag pattern -> do
--      let title = "Posts tagged \"" ++ tag ++ "\""
--      route idRoute
--      compile $ do
--        posts <- chronological =<< loadAll pattern
--        let ctx = constField "title" title <>
--                  listField "posts" postCtx (return posts) <>
--                  defaultContext
--        makeItem ""
--          >>= loadAndApplyTemplate "templates/tags.html" ctx
--          >>= loadAndApplyTemplate "templates/default.html" ctx
--          >>= relativizeUrls
--    match "posts/*" $ do
--         route $ setExtension "html"
--         compile $ pandocCompiler
--             >>= loadAndApplyTemplate "templates/post.html"    (postCtxWithTags tags)
--             >>= saveSnapshot "content"
--             >>= loadAndApplyTemplate "templates/default.html" (postCtxWithTags tags)
--             >>= relativizeUrls
--    create ["archive.html"] $ do
--         route idRoute
--         compile $ do
--             posts <- recentFirst =<< loadAll "posts/*"
--             let archiveCtx =
--                     listField "posts" postCtx (return posts) <>
--                     constField "title" "Archives"            <>
--                     defaultContext
--             makeItem ""
--                 >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
--                 >>= loadAndApplyTemplate "templates/default.html" archiveCtx
--                 >>= relativizeUrls
--    create ["rss.xml"] $ do
--         route idRoute
--         compile $ do
--           let feedCtx = postCtx <> bodyField "description"
--           posts <- fmap (take 10) . recentFirst =<<
--                    loadAllSnapshots "posts/*" "content"
--           renderRss feedConfig feedCtx posts
--    match "index.html" $ do
--         route idRoute
--         compile $ do
--             posts <- recentFirst =<< loadAll "posts/*"
--             let indexCtx =
--                     listField "posts" postCtx (return posts) <>
--                     constField "title" ""        <>
--                     defaultContext
--             getResourceBody
--                 >>= applyAsTemplate indexCtx
--                 >>= loadAndApplyTemplate "templates/default.html" indexCtx
--                 >>= relativizeUrls
--    match "templates/*" $ compile templateCompiler
-- --------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    defaultContext

postCtxWithTags :: Tags -> Context String
postCtxWithTags tags = tagsField "tags" tags <> postCtx