---
title: Review of Thoughtful Machine Learning
---
&nbsp;In the last couple of months, we have been using a lot of machine learning to improve the accuracy of the data that we are displaying on our platform. One of the most urgent problem with using machine learning models was how we handle validating that the data is indeed correct (in the real time stream). So while skimming through the next book to read, I came upon <em>Thoughtful Machine Learning</em> which advertised itself as presenting a "test-driven approach" to writing machine learning applications. So I thought "hey, I'm an engineer, and our models currently suck... so maybe this book will help with our current problems in our system!". So here is a review of <a href="http://shop.oreilly.com/product/0636920032298.do">Thoughtful Machine Learning</a> by Matthew Kirk.

<!--more-->
<h1>Review</h1>
The book gives a good exposition to various machine learning algorithms that are commonly used and useful engineering caveats. In the preface, Kirk mentioned that the book is aimed for the developer, CTO and business analyst. Therefore the presentation of the content is terse and meant to be useful without going into some of the mathematical depth. The first chapter presented a good overview of the machine learning methodology and how testing fits into the framework of thought. The last two chapters then presents other testing techniques commonly used in machine learning for model verification (such as cross validation and precision recall). As someone who is already familiar with machine learning, it wasn't really anything new. Admittedly, I just scanned over these sections so can't really comment on them too much.

The core of the book is then divided into chapters dedicated to specific algorithms such as K-nearest neighbours and neural networks. Each chapter summarizes the algorithm, then presents an example problem that can be solved with the algorithm. There is code that accompanies the example problem which shows how it should be implemented and corresponding unit tests to test for functionality. I was hoping that I would get more insight into building a testing framework on top of machine learning applications, but most of the testing presented in the book are derived from unit testing. It is still useful, but I was hoping to gain more insight into testing methodologies outside standard software testing.

One of the main problems with this book is that it is written in Ruby. On one hand, there aren't many machine learning books written in Ruby, so it is worth writing one for Rubyists. However, there is a good reason why there aren't many books about machine learning written in Ruby: there is not much support or advantage over more established languages like Python or R or even Java. Also, the syntax used for writing tests in Ruby seemed strange to me, and I had some trouble discerning actual implementation from the code itself (coming from python/java background... where your tests generally have "test" somewhere in the classname or method names). This really bothered me as I didn't find the large chunks of code throughout the book useful at all.
<h1>Conclusion</h1>
Tl;dr:
<ul>
<li>good introduction to machine learning that is accessible and practical</li>
<li>you can use unit testing for machine learning</li>
<li>book is written in Ruby, which isn't the language of data-analysis, but if you're looking to implement machine learning in Ruby, then this is good for you</li>
<li>can skim for data-analyst. If you do this in your day job... then you probably won't learn much</li>
</ul>
&nbsp;


