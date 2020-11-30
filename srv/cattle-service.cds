using { dalrae.saug.demo as schema } from '../db/schema';
service CattleService @(path: '/cattle') {
  entity Paddocks as projection on schema.Paddocks;
  entity Cattles as projection on schema.Cattles;
  @readonly entity Locations as projection on schema.Locations {
    *,
    paddock.location as location,
    cattle.cattleName as cattleName
  } order by timestamp desc;
}