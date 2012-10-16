# Searching With Solr

Resources:

http://www.solrtutorial.com

http://sunspot.github.com


Synonyms do not work out of the box!  Edit `solr/conf/schema.xml` as reflected below:

````
    <fieldType name="text" class="solr.TextField" omitNorms="false">
      <analyzer>
        <tokenizer class="solr.StandardTokenizerFactory"/>
        <filter class="solr.StandardFilterFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <!-- *** ADD THE BELOW FOR SYNONYMS TO WORK -->
        <filter class="solr.SynonymFilterFactory" synonyms="synonyms.txt" ignoreCase="true" expand="true" />
      </analyzer>
    </fieldType>
````