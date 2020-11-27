using { dalrae.saug.demo as schema } from '../db/schema';
service CattleService @(path: '/cattle') {
  entity Paddocks as projection on schema.Paddocks;
  entity Cattles as projection on schema.Cattles;
}