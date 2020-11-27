namespace dalrae.saug.demo;

using { Currency, managed, cuid, sap } from '@sap/cds/common';

entity Paddocks : managed, cuid {
  location: String(100);
  acres: Integer;
  maxCattle: Integer;
  virtual numberOfCattle : Integer;
  cattles: Composition of many Cattles on cattles.paddock = $self;
}

entity Cattles : managed, cuid {
  name: String(20);
  gender: String(1);
  paddock: Association to Paddocks;
}