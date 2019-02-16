# MDBaseGenerator

This project allows to generate the base of a Seaside application using [Material Design Lite for Seaside](https://github.com/DuneSt/MaterialDesignLite) as I like to build them.

## Install

```Smalltalk
    Metacello new
    	githubUser: 'jecisc' project: 'MDBaseGenerator' commitish: 'master' path: 'src';
    	baseline: 'MDBaseGenerator';
    	load
```

## Generate the application

To generate the application you can parametrize and execute this script:

```Smalltalk
MDBaseGenerator new
	prefix: 'MDE';
	packageName: 'MDExample-WebApplication';
	projectName: 'MDExample';
	withFooter: true;
	withDrawerHeader: false;
	rootHtmlClass: 'mdexample';
	title: 'Application example for MDL.';
	primaryColor: MDLColor deepPurple;
	accentColor: MDLColor pink;
	cssInFileLibrary: true;
	generate
```

### Parameters

- `accentColor`: This color will be used as accent color (secondary/highlight color) of the MDL application. It should be an instance of MDLColor but cannot be brown, grey or blue grey. For example: `MDLColor pink`.
- `cssInFileLibrary`: This parameter should be a boolean. If it is true, the MDL CSS will be stored in the FileLibrary of the application, else the header will reference an external resource.
- `packageName`: This parameters defines the name of the package containing the application generated. For example: `MyApplication-Seaside`.
- `prefix`: This parameter defines the prefix of generated classes. For example: `MA`.
- `primaryColor`: This color will be used as primary color of the MDL application. It should be an instance of MDLColor. For example: `MDLColor deepPurple`.
- `projectName`: This parameter defines the project name. This name will be used as route of the application in Seaside registration and also for some comments. For example: `MyApplication`.
- `rootHtmlClass`: This parameter defines a css class to add to the root component of the application to help with the CSS. For example: `my-application`.
- `title`: This parameter defines the title to display in the tab of the application. For example: `Title of my application!`.
- `withDrawerHeader`: This parameter should be a boolean and defines if the application will have a menu as tabs or as a drawer.
- `withFooter`: This parameter defines if the application should have a footer or not.

## Description of the generator application

TODO
