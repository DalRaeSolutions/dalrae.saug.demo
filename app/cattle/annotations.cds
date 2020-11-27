using CattleService as service from '../../srv/cattle-service';

@odata.draft.enabled
annotate service.Cattles with @(
	UI: {
		LineItem: [
			{Value: cattleName},
			// this only adds an action to the title bar, not to the line item
			{Value: gender_code},
			{
				$Type:'UI.DataFieldWithUrl',
				Value: paddock.location,
				Url: urlToCustomer,
        Label: '{i18n>Location}'
			},
		],
    /**
      This is for the object page
     */
		HeaderInfo: {
			TypeName: '{i18n>Cattle}', TypeNamePlural: '{i18n>Cattles}',
			Title: {
				Value: cattleName
			},
			Description: {Value: paddock.location}
		},
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Paddock}', Target: '@UI.FieldGroup#Paddock'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Admin}', Target: '@UI.FieldGroup#Admin'},
		],
		FieldGroup#General: {
			Data: [
				{Value: cattleName, Label: 'Name'},
				{Value: gender_code},
			]
		},
		FieldGroup#Paddock: {
			Data: [
				{Value: paddock_ID},
				//{Value: paddock.maxCattle},
				//{Value: paddock.numberOfCattle, Label: '{i18n>NumberOfCattle}'},
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
	}
) {
	gender @title: '{i18n>Gender}' @sap.semantics: 'fixed-values' @Common: { Text: gender.descr,  TextArrangement: #TextOnly };
	paddock @ValueList: { entity:'Paddocks', type: #fixed } @title: '{i18n>Paddock}' @sap.semantics: 'fixed-values' @Common: { Text: paddock.location,  TextArrangement: #TextOnly };
};

annotate service.Paddocks with {
	ID @title:'{i18n>ID}' @UI.HiddenFilter;
	numberOfCattle  @title:'{i18n>NumberOfCattle}';
	maxCattle @title:'{i18n>MaxCattle}';
	location @title:'{i18n>Location}';  
	paddock_ID @title:'{i18n>Paddock}' 
}