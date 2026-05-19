// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  // Handcrafted sidebar mirroring the nebari-docs Diátaxis structure:
  // Introduction · Get started · How-to guides · Reference. Each
  // category uses a clickable index doc as the landing page (the
  // `link: { type: 'doc', id: '<dir>/index' }` pattern from
  // nebari-dev/nebari-docs/docs/sidebars.js).
  docsSidebar: [
    'introduction',
    {
      type: 'category',
      label: 'Get started',
      link: { type: 'doc', id: 'get-started/index' },
      items: ['get-started/deploy'],
    },
    {
      type: 'category',
      label: 'How-to guides',
      link: { type: 'doc', id: 'how-tos/index' },
      items: [
        'how-tos/use',
        'how-tos/troubleshoot',
      ],
    },
    {
      type: 'category',
      label: 'Reference',
      link: { type: 'doc', id: 'references/index' },
      items: [
        'references/values',
        'references/architecture',
      ],
    },
  ],
};

module.exports = sidebars;
