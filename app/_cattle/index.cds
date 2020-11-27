using CattleService from '../../srv/cattle-service';

////////////////////////////////////////////////////////////////////////////
//
//	Books Object Page
//
annotate CattleService.Cattles with @(
	UI: {
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>General}', Target: '@UI.FieldGroup#General'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Paddock'},
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Admin}', Target: '@UI.FieldGroup#Admin'},
		],
		FieldGroup#General: {
			Data: [
				{Value: name},
				{Value: gender},
			]
		},
		FieldGroup#Paddock: {
			Data: [
				{Value: paddock.location},
				{Value: paddock.maxCattle},
				{Value: paddock.numberOfCattle, Label: '{i18n>NumberOfCattle}'},
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
);