--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

--------------------------------------------------------------------------------

myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "Michelle's [uncreative adjective] Blog"
    , feedDescription = "...because there is not enough content on the internet "
    , feedAuthorName  = "Michelle Tran"
    , feedAuthorEmail = "email@michtran.ca"
    , feedRoot        = "http://michtran.ca/blog/"
    }

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "index.html" $ do
        route   idRoute
        compile copyFileCompiler

    match "robots.txt" $ do
        route   idRoute
        compile copyFileCompiler

    match "favicon.ico" $ do
        route   idRoute
        compile copyFileCompiler

    match "public.key" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["blog/about.rst", "blog/contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "blog/templates/default.html" defaultContext
            >>= relativizeUrls

    match "blog/posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "blog/templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "blog/templates/default.html" postCtx
            >>= relativizeUrls

    create ["blog/archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "blog/posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "blog/templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "blog/templates/default.html" archiveCtx
                >>= relativizeUrls

    create ["atom.xml"] $ do
        route idRoute
        compile $ do
             let feedCtx = postCtx `mappend` bodyField "description"
             posts <- fmap (take 3) . recentFirst =<<
                 loadAllSnapshots "blog/posts/*" "content"
             renderAtom myFeedConfiguration feedCtx posts

    match "blog/index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "blog/posts/*"
            let indexCtx =
                    listField "posts" postCtx (return (take 5 posts)) `mappend`
                    constField "title" "Michelle's [uncreative adjective] Blog..."  `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "blog/templates/default.html" indexCtx
                >>= relativizeUrls

    match "blog/templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
