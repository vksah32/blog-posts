# On parquet storage

See [blog](https://blog.twitter.com/engineering/en_us/a/2013/dremel-made-simple-with-parquet.html) by twitter - inspired from dremmel paper

Main points from blog:

here are several advantages to columnar formats.

- Organizing by column allows for better compression, as data is more homogenous. The space savings are very noticeable at the scale of a  Hadoop cluster.
- I/O will be reduced as we can efficiently scan only a subset of the columns while reading the data. Better compression also reduces the  bandwidth required to read the input.
- As we store data of the same type in each column, we can use  encodings better suited to the modern processors’ pipeline by making  instruction branching more predictable.

Data model -> similar to protobuf

One column for each primitive type -> after converting nested schema into a tree -> look at leaf nodes, stores definition leve (nested-level) and repetition level (for arrays) , see examples in the twitter blog, they are very clear





---------

Avro

https://avro.apache.org/docs/1.8.2/gettingstartedjava.html









