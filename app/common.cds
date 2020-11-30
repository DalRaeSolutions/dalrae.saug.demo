using { dalrae.saug.demo as schema } from '../db/schema';

@cds.odata.valuelist
@sap.semantics: 'fixed-values'
annotate schema.Paddocks with @(
	Common.SemanticKey: [location],
	UI: {
		LineItem: [
			{Value: location},
			// this only adds an action to the title bar, not to the line item
			{Value: maxCattle},
			{Value: numberOfCattle}
		]
	}
) {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	numberOfCattle  @title:'{i18n>NumberOfCattle}';
	maxCattle @title:'{i18n>MaxCattle}';
	location @title:'{i18n>Location}' @UI.Common.Label: 'Location';
}

@cds.odata.valuelist
@sap.semantics: #fixedvalues
annotate schema.Cattles with @(
  Common.SemanticKey: [cattleName]
) {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	cattleName @title:'{i18n>Name}' @UI.Common.Label: '{i18n>Name}';
	gender @title: '{i18n>Gender}' @sap.semantics: 'fixed-values' @Common: { Text: gender.descr,  TextArrangement: #TextOnly };
	gender_code @title: '{i18n>Gender}' @sap.semantics: 'fixed-values' @Common: { Text: gender.descr,  TextArrangement: #TextOnly };
};

@cds.odata.valuelist
@sap.semantics: #FIXED_VALUES 
annotate schema.Gender with @(
	Common.SemanticKey: [descr],
	Identification: [{Value:code}],
	UI: {
		SelectionFields: [ code, descr ],
		LineItem:[
			{Value: code,},
			{Value: descr },
		],
	}
) {
	code @title : '{i18n>GenderCode}' @UI.Common.Label: '{i18n>GenderCode}';
	descr @title : '{i18n>GenderDescr}' @UI.Common.Label: '{i18n>GenderDescr}';
};

@cds.odata.valuelist
@sap.semantics: #FIXED_VALUES 
annotate schema.Occupancy with @(
	Common.SemanticKey: [descr],
	Identification: [{Value:code}],
	UI: {
		SelectionFields: [ code, descr ],
		LineItem:[
			{Value: code,},
			{Value: descr },
		],
	}
) {
	code @title : '{i18n>Occupancy}' @UI.Common.Label: '{i18n>Occupancy}';
	descr @title : '{i18n>Occupancy}' @UI.Common.Label: '{i18n>Occupancy}';
};