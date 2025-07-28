# README

This project adds a second “meta” database of metapages to a lepiter database to support reviewing and annotation of pages.
Currently it is used to review the GT Book. Just load this repo  as below to add actions to all GT book pages to access or create meta pages.
## Installation

```st
Metacello new
	repository: 'github://feenkcom/gtoolkit-metabook:main/src';
	baseline: 'GtoolkitMetabook';
	load.
#BaselineOfGtoolkitMetabook asClass loadLepiter.
#BaselineOfGtoolkitMetabook asClass loadLepiterMetabook.
#BaselineOfGtoolkitMetabook asClass loadLepiterGtbookExamples.
```
