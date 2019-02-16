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

### Session

The generated application will have a custom session. This session will be used to store the root component. Like this, all the components of the application will be able to access the root component. This is useful to implement some navigation because like that each component can ask to the root to change the current browser to display.

### Root component

The root component of the generated application will display a header and optionaly a footer. It will also display a main component. When we change of main component, the previous instances are kept. Like that it is possible to come back to a previous browser and to keep the state. 

To display a browser you can execute in all components

```Smalltalk
self displayInstanceOf: aClass
```

To no get back the previous instance you can do:

```Smalltalk
self display: aClass new
```

The main component should be a subclass of the {Prefix}Page class. The name of the page will be added to the URL and the link will be sharable. If we get the URL with the page name, the right page will be displayed.
