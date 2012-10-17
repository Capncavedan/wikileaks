# Searching With Solr

### Resources:

http://www.solrtutorial.com

http://sunspot.github.com


### Wikileaks cables:

Use included torrent file `WikiLeaks_uncensored_US_diplomatic_cables_(cables.csv).6644050.TPB.torrent`

Note that the `cables.csv` file it downloads is over 1.6 GB, so will take a while to download and also to import (if you choose to import all of it)

It can be parsed with the `db/import_cables.rb` script; adjust the path within it to your local `cables.csv` file, then open a rails console and use `load "db/import_cables.rb"`


### Synonyms

Synonyms are not enabled out of the box!  Edit `solr/conf/schema.xml` as reflected below:

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