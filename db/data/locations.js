const cattle = ['4d73f359-6182-4612-a8ad-8bedcfa77e88',
'520e26dc-be7b-48c2-85e3-b14013c25f3a',
'e517ca1b-0c92-4306-9502-736f5e429f58',
'008943ac-6dde-47fe-80d5-854257771966',
'455ca5bb-baaa-4060-8011-1d1da9a67e5b',
'b3238100-a607-40ba-8527-5457bd9ab6ab',
'464cdd97-1b3f-4199-9e93-13ad35467e28',
'89f3615a-1d49-4585-8d8b-605ab93137ca',
'62b6414b-fe6a-415c-ad73-0f157022a4ea',
'a3ec85ac-1b6e-42f4-9e91-0448b293ac8f']

const paddocks = [
'8caf60df-618b-4abe-861f-ea52f39d5eff',
'c1803f38-9fd7-4485-bc03-adf48ad9a7ee'];

const locations = [['timestamp', 'paddock_ID', 'cattle_ID']];

const n = new Date(new Date().setMonth(10));

paddocks.forEach(p => {
  cattle.forEach(c => {
    new Array(10).fill(1).map((_, i) => i).map(i => new Date(new Date(new Date(n.getTime())).setDate(i))).forEach(d => {
      locations.push([d.toISOString(), p, c]);
    });
  });
});

require('fs').writeFileSync('dalrae.saug.demo-Locations.csv', locations.map(f => f.join(';')).join('\n'))