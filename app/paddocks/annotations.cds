using PaddockService as service from '../../srv/paddock-service';

@odata.draft.enabled
annotate service.Paddocks with @(
	Common.SemanticKey: [location],
	Identification: [{Value:location}],
	UI: {
			SelectionFields: [ location, acres ],
			LineItem: [
			{Value: location},
			{Value: acres},
			{Value: maxCattle},
			{Value: numberOfCattle},
		],
    /**
      This is for the object page
     */
		HeaderInfo: {
			TypeName: '{i18n>Cattle}', TypeNamePlural: '{i18n>Cattles}',
			Title: {
				Value: location
			}
		},
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>CattleList}', Target: 'cattles/@UI.LineItem'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>CattleHistory}', Target: 'locations/@UI.LineItem'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Admin}', Target: '@UI.FieldGroup#Admin'},
		],
		FieldGroup#General: {
			Data: [
				{Value: location, Label: 'Location'},
				{Value: acres},
				{Value: maxCattle},
				{Value: numberOfCattle},
			]
		},
		FieldGroup#Admin: {
			Data: [
				{Value: createdBy},
				{Value: createdAt},
				{Value: modifiedBy},
				{Value: modifiedAt}
			]
		}	
	},
) {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	numberOfCattle  @title:'{i18n>NumberOfCattle}';
	maxCattle @title:'{i18n>MaxCattle}';
	location @title:'{i18n>Location}';  
	acres @title:'{i18n>Acres}';  
	paddock_ID @title:'{i18n>Paddock}' ;
}

annotate service.Locations with @(
	Capabilities: { Insertable:false, Updatable:false, Deletable:false },
	Common.SemanticKey: [paddock.location],
	Identification: [{Value:location}],
	UI: {
			LineItem: [
			{Value: timestamp},
			{Value: createdBy},
			{Value: cattleName},
		],
		PresentationVariant: {
			SortOrder: [
				{Property: 'timestamp', Descending: false}
			],
			GroupBy: ['timestamp']
		}
	}
) {
	cattleName @readonly
}

annotate service.Cattles with @(
	Capabilities: { Insertable:false, Updatable:false, Deletable:false },
	Common.SemanticKey: [cattleName],
	Identification: [{Value:cattleName}],
	UI: {
			LineItem: [
			{Value: cattleName},
			{Value: gender_code},
			{Value: cattleName},
		],
		PresentationVariant: {
			SortOrder: [
				{Property: 'cattleName', Descending: false}
			],
			GroupBy: ['cattleName']
		}
	}
) {
	cattleName @readonly;
	gender @title: '{i18n>Gender}' @sap.semantics: 'fixed-values' @Common: { Text: gender.descr,  TextArrangement: #TextOnly };
	paddock @ValueList: { entity:'Paddocks', type: #fixed } @title: '{i18n>Paddock}' @sap.semantics: 'fixed-values' @Common: { Text: paddock.location,  TextArrangement: #TextOnly };
}