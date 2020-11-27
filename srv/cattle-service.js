/**
 * @module Services
 * 
 * @param {cds.Service} srv 
 */
module.exports = (srv) => {
  const { Paddocks, Cattles } = srv.entities;

  srv.before(['CREATE', 'UPDATE', 'EDIT'], Paddocks, async req => {
    const { location, acres, maxCattle } = req.data;

    if (!location) req.error(400, `'location' is a mandatory field`);
    if (!acres) req.error(400, `'acres' is a mandatory field`);
    if (!maxCattle) req.error(400, `'maxCattle' is a mandatory field`);
  });

  srv.after(['READ', 'EDIT'], Paddocks, async (paddocks, req) => {
    const paddocksByID = paddocks.reduce((all, o) => { (all[o.ID] = o).numberOfCattle = 0; return all }, {});
    const query = SELECT.from(Cattles).columns('paddock_ID', 'count(paddock_ID)')
      .where({ paddock_ID: { in: Object.keys(paddocksByID) } })
      .groupBy('paddock_ID');

    return cds.transaction(req).run(query).then(cattles => cattles.forEach(cattle => paddocksByID[cattle.paddock_ID].numberOfCattle = cattle[ 'count ( paddock_ID )']))
  })
};