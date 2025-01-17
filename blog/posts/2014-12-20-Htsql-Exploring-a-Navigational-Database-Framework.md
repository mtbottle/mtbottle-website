---
title: Htsql - Exploring a Navigational Database Framework
---
A couple of weeks ago, one of my colleagues brought up an alternative query language to SQL. My first reaction was <i>why do we need a substitute for SQL?</i> Well, there things that are implicit in the database structure but not expressed very well in SQL. For example, consider the following normalized tables:
<pre lang="sql">
CREATE TABLE foo(
  id SERIAL PRIMARY KEY,
  some_foo_param VARCHAR
);
CREATE TABLE bar(
  id SERIAL PRIMARY KEY,
  some_bar_param VARCHAR
);
/* Declare many-to-many mapping */
CREATE TABLE foo_bar_mapping(
  foo_id INTEGER REFERENCES foo (id),
  bar_id INTEGER REFERENCE bar (id)
);
</pre>
So what would the join query look like if you need to do a join on both <code>foo</code> and <code>bar</code>?
<pre lang="sql">/* Query to extract all possible combinations of the params from the two tables */
SELECT foo.some_foo_param, bar.some_bar_param
FROM foo JOIN foo_bar_mapping ON foo.id = foo_bar_mapping.foo_id
  JOIN bar ON bar.id = foo_bar_mapping.bar_id;
</pre>
This query to join the tables still require you to specify the join conditions that <i>should have been inferred from the table definition</i>. This is why there exists the alternative query language: <a href="http://htsql.org/doc/overview.html#why-not-sql">htsql</a>.

<!--more-->
<h1>Why htsql?</h1>
Admittedly, there are many <a href="http://htsql.org/doc/overview.html#why-not-sql">more reasons</a> for using htsql (aside from the problem presented above which so bothered my coworker). Htsql uses <a href="https://en.wikipedia.org/wiki/Navigational_database">navigational database model</a> (rather than the relational model used by SQL), which means that relationships are implicit in the structure of the query. For example, the above SQL query above will look like this in htsql:
<pre>/foo_bar_mapping{foo.some_foo_param, bar.some_bar_param}</pre>
The query is both shorter and simpler than the SQL query because there is no need for joins. The relationship between foo_bar_mapping, foo and bar are all implicit. The relationship between the two tables is called a <em>link</em> in htsql's vernacular. Since this makes the language more terse, it also helps prevent incorrect business queries.

Another benefit to htsql is that the syntax is modelled after query language, which means that people who are familiar with writing web queries can easily pick up the language. Since the core tenet of htsql is to make the language accessible for business, this extensibility is quite nice.
<h2>Using htsql</h2>
Installation of htsql on my database server was quite simple. I followed the instructions <a href="http://htsql.org/download">on the htsql website</a> and was able to get it working straight out of the box. To access the database through command line, you type in
<pre>htsql-ctl shell [pgsql|mysql]:[NAME_OF_DATABASE]</pre>
where you substitute <code>pgsql</code> if you are using postgres database or <code>mysql</code> if you are using a mysql database. To get a list of your tables or describe your table in the database, you type in
<pre>describe [TABLENAME]</pre>
and you should get back a list of tables or the relationships in the table. This is very useful to see how the navigational relationships for your tables work in htsql. For example, if I was to type in <code>describe foo_bar_mapping</code>, I will get an output that looks like:
<pre>
FOO_BAR_MAPPING - table

SQL name:
  public.foo_bar_mapping

Unique keys:
  public.foo_bar_mapping(id) {primary}

Foreign keys:
  public.foo_bar_mapping(foo_id) -&gt; public.foo(id)
  public.foo_bar_mapping(bar_id) -&gt; public.bar(id)

Identity:
  id

Labels:
  id : integer column
  foo : link to foo
  bar : link to bar
</pre>
So to construct your htsql queries, you can access the labels directly without requiring to specify the join or an external table.

There is also a nice python interface that you can connect to for applications. The documentation for that is <a href="http://htsql.org/doc/embed.html">here</a>.
<h3>Filtering</h3>
Filtering is analogous to what you would put in the "where" clause in a SQL query. In htsql, this looks very similar to query language. For example, if I wanted to get all the values of <code>foo</code> where all the associated <code>some_bar_param</code> had the value "match me":
<pre>/foo?foo_bar_mapping.bar.some_bar_param="match me"</pre>
The placement of <code>?</code> determines what is returned. In this case above, we are querying for values of <code>foo</code> which will return us <code>foo.id</code> and <code>foo.some_foo_param</code>. But if you move the <code>?</code> such that your filter looks like :
<pre>/foo.foo_bar_mapping?bar.some_bar_param="match me"</pre>
then you will be returning values from <code>foo_bar_mapping</code>. To control for the values that you want to return, you can set <code>{}</code>. So for example, if you want to return only <code>foo.some_foo_param</code>:
<pre>/foo?foo_bar_mapping.bar.some_bar_param="match me"{some_foo_param}</pre>
This is slowly becoming less and less intuitive as the return values are now distant from where the table is returned.
<h3>Projection</h3>
Htsql makes very clear that there is a difference between projecting a database table with aggregating results from it. In relationally based languages, we would write a query for projection with the aggregation semantics <code>GROUP BY</code>. For example, if we wanted to count the unique number of <code>bar.id</code>'s for a particular <code>foo.id</code>, we would write it in sql:
<pre lang="sql"> SELECT foo.id, COUNT(UNIQUE bar.id) from foo JOIN foo_bar_mapping on foo.id = foo_bar_mapping.foo_id
JOIN bar on foo_bar_mapping.bar_id = bar.id
GROUP BY foo.id;</pre>
In a navigational framework, the semantics of <code>GROUP BY</code> is misleading as we are not really grouping elements together, but rather we are <em>projecting</em> the multidimensional data onto a "summarized" (or lower dimensional) form. So in htsql, this will look like:
<pre>/foo^id {id, count(foo_bar_mapping.bar.id)}</pre>
where <code>^</code> is the projecting the table <code>foo</code> onto the unique <code>foo.id</code>'s. In both relational and navigational syntax, we cannot get away with also adding summary operators (like <code>COUNT</code>, <code>MAX</code>, <code>MIN</code>, etc.).
<h1>Impressions</h1>
Although learning htsql was a great way to introduce a different database querying model, I had a couple of issues with using it.
<h2>Different way of thinking about queries</h2>
Since htsql is a different paradigm from relational model to a navigational model, the way you think about the queries takes a bit of getting used to. Rather than thinking of how you can <em>use the structure of the data</em> to get at the particular data you want, you now have to think about <em>how do I navigate the data</em> to get at the data that you want. While attempting to use htsql for some moderately complex queries (required 6 joins), I found myself just resorting back to relational sql as figuring out how to navigate through 6 tables was non-trivial (documentation is also not the greatest, and obscurity of the framework meant that there wasn't going to be much help on google).

I would argue that the relational way of thinking (of what data to get) is much more intuitive than the navigational way of thinking when you need pieces of data from multiple sources. This is because relational syntax is fairly intuitive for grabbing data if you know where and what you want to get. Whereas if you were to use navigational framework, you will also need to work out <em>how to traverse the data</em> to get what you want. This leads me to think that navigational frameworks are more appropriate when your data has more of a graph-like structure where you need to frequently query for very specific encapsulated nodes of data. Since I needed to output lots of data from multiple joined tables in the data I was experimenting with, it was not the best use case for a navigational querying framework.
<h2>Dealing with Complexity</h2>
As mentioned in the previous section, I found that as your business logic becomes increasingly complex, so does your htsql query. In addition to the less intuitive language (you can't really argue with how SQL queries read out like English), a complex query in htsql can take more time to understand than it would in SQL. Of course, this is somewhat subjective, so I'll present an example of an actual SQL query that I used for work (obfuscated intentionally to not leak too much work related info):
<pre lang="sql">
select ea.id,
  geolocation.longitude,
  geolocation.latitude,
  geolocation.country_name,
  geolocation.toponym_name,
  article.title,
  article.content,
  ea_category_.category
from ea
  join ea_category_ on ea.id = ea_category_.ea_id
  join ea_geolocation_ on ea.id = ea_geolocation_.ea_id
  join geolocation on ea_geolocation_.geolocation_id = geolocation.id
  join eb_to_ea_mapping on eb_to_ea_mapping.ea_id = ea.id
  join eb on eb_to_ea_mapping.eb_id = eb.id
  join article on eb.article_id = article.id
  join (select ea_geolocation_.ea_id as id, max(geolocation.country_name) as max_geo
      from ea_geolocation_ join geolocation on ea_geolocation_.geolocation_id = geolocation.id
      group by ea_geolocation_.ea_id) as max_geo_table
    on ea.id = max_geo_table.id
where
  ea.verified_category = 't'
  and ea_geolocation_.best = 't'
  and ea_category_.best = 't'
  and max_geo_table.max_geo not in ('United States','United Kingdom','Canada','Australia','New Zealand')
order by ea.id desc
limit 100;
</pre>
This is a relatively complex query where I'm getting information from more than one table. This is what it will look like when I write the same query with htsql:
<pre>
/ea?verified_category=true
  {id,
  /ea_geolocation_?best=true{geolocation.longitude,
    geolocation.latitude,
    geolocation.country_name,
    geolocation.toponym_name},
  /eb_to_ea_mapping.eb.article{title,
    content},
  /ea_category_?best=true{category}
  }.sort(id-)
   .limit(100)?max(ea_geolocation_.geolocation.country_name)!=
      {'United States','United Kingdom','Canada','Australia','New Zealand'}
</pre>
The htsql form is noticeably shorter and more compact. However, the filtering logic is all over the place (grep for ?) whereas the filtering logic in the SQL query is all blocked up in the where clause (although you can perhaps argue that my subquery to create <code>max_geo_table</code> puts business logic somewhere it doesn't belong...). Nevertheless, because of the <em>"navigational"</em> aspect of htsql syntax, filtering is not encapsulated in a predictable block of your query which means that you can end up with a query where you have filtering logic all over the place.
<h2>Performance Issues</h2>
Compared to relational queries (straight into postgresql CLI), the same query performed on htsql was an order of magnitude slower than the same relational query [anecdotal...&nbsp; I was too lazy to do some actual benchmarking]. Also, we cannot take advantage of the numerous <a href="https://en.wikipedia.org/wiki/Query_optimization">SQL optimizations</a> that have been documented throughout the years. Since htsql <a href="http://htsql.org/doc/overview.html#htsql-is-a-relational-database-gateway">gets translated to SQL anyways</a>, this abstraction might not be ideal if performance is important. Therefore, even if the queries are now easier to write, the performance trade off isn't worth the hassle of learning or integrating another program on top of the database's native interface.
<h1>Conclusion</h1>
This is just an overview about what I think is interesting about htsql and navigational database framework. There is a lot more theory that I completely ignored in this blog post (mostly because I didn't need it for getting the htsql queries to work for my data). Unfortunately, I found the documentation somewhat lacking for more more practical applications, but it still gave enough basics that you can play around to build the query yourself. I would suggest reading the <a href="http://htsql.org/doc">documentation</a> for the theory behind the design.&nbsp; Other things that I found interesting are : <a href="http://htsql.org/blog/2012/introducing-nested-segments.html">implicitly linked nested subqueries</a> (super useful...),&nbsp; and <a href="http://htsql.org/doc/ref/model.html">theory about the model graph</a>.
