using CattleService as service from '../../srv/cattle-service';

@odata.draft.enabled
annotate service.Cattles with @(
	Common.SemanticKey: [cattleName],
	UI: {
		SelectionFields: [ cattleName, paddock_ID ],
		Identification: [{Value:cattleName}],
		LineItem: [
			{Value: cattleName, Label: 'Name'},
			// this only adds an action to the title bar, not to the line item
			{Value: gender_code},
			{Value: paddock_ID},
		],
		PresentationVariant: {
			SortOrder: [
				{Property: 'cattleName', Descending: true}
			]
		},
    /**
      This is for the object page
     */
		HeaderInfo: {
			TypeName: '{i18n>Cattle}', TypeNamePlural: '{i18n>Cattles}',
			Title: {
				Value: cattleName
			}
		},
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>LocationHistory}', Target: 'locations/@UI.LineItem'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Admin}', Target: '@UI.FieldGroup#Admin'},
		],
		FieldGroup#General: {
			Data: [
				{Value: gender_code},
				{Value: paddock_ID}
			]
		},
		// FieldGroup#Paddock: {
		// 	Data: [
		// 		{Value: paddock_ID},
		// 		//{Value: paddock.maxCattle},
		// 		//{Value: paddock.numberOfCattle, Label: '{i18n>NumberOfCattle}'},
		// 	]
		// },
		FieldGroup#Admin: {
			Data: [
				{Value: createdBy},
				{Value: createdAt},
				{Value: modifiedBy},
				{Value: modifiedAt}
			]
		}
	}
) {
	cattleName @title: 'Name';
	gender @title: '{i18n>Gender}' @sap.semantics: 'fixed-values' @Common: { Text: gender.descr,  TextArrangement: #TextOnly };
	paddock @ValueList: { entity:'Paddocks', type: #fixed } @title: '{i18n>Paddock}' @sap.semantics: 'fixed-values' @Common: { Text: paddock.location,  TextArrangement: #TextOnly };
	paddock_ID @ValueList: { entity:'Paddocks' } @title: '{i18n>Paddock}' @sap.semantics: 'fixed-values';
};

annotate service.Paddocks with @(
	Common.SemanticKey: [location],
	Identification: [{Value:location}],
	UI: {
			LineItem: [
			{Value: location},
			{Value: acres},
		],	
	}
) {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	numberOfCattle  @title:'{i18n>NumberOfCattle}';
	maxCattle @title:'{i18n>MaxCattle}';
	location @title:'{i18n>Location}';  
	paddock_ID @title:'{i18n>Paddock}' 
}

annotate service.Locations with @(
	Capabilities: { Insertable:false, Updatable:false, Deletable:false },
	Common.SemanticKey: [paddock.location],
	Identification: [{Value:location}],
	UI: {
			LineItem: [
			{Value: timestamp},
			{Value: createdBy},
			{Value: location },
		],
		PresentationVariant: {
			SortOrder: [
				{Property: 'timestamp', Descending: false}
			],
			GroupBy: ['timestamp']
		}
	}
) {
	location @readonly
}