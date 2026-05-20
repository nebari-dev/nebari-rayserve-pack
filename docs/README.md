# Nebari Ray Serve Pack Documentation

This directory contains the [Docusaurus 3.5.2](https://docusaurus.io/) site for the Nebari Ray Serve pack.

## Prerequisites

- Node.js `>= 18` (enforced by the `engines` field in `package.json`).
- npm. The site has been built and tested against Node 20.19.5 / npm 10.8.2.

## Install

```bash
cd docs
npm install
```

## Local development

```bash
npm run start
```

Starts the Docusaurus dev server with hot reload on http://localhost:3000/nebari-rayserve-pack/.

Note: the lunr search index is generated only by `npm run build`. The search box in the dev server will return no results; use a production build to exercise search.

## Production build

```bash
npm run build
```

Emits static files to `docs/build/`. The build step also produces the lunr search index via `docusaurus-lunr-search`.

## Preview the production build

```bash
npm run serve
```

Serves the contents of `docs/build/` locally so you can verify the production output, including search.

## Troubleshooting

### `ValidationError: Invalid options object. Progress Plugin has been initialized using an options object that does not match the API schema`

This is a webpack-version mismatch. Docusaurus 3.5.2 targets webpack 5.94; webpack 5.97+ tightens the `ProgressPlugin` options schema and rejects what Docusaurus passes. `package.json` pins the resolution with:

```json
"overrides": {
  "webpack": "5.94.0"
}
```

npm applies `overrides` only on a fresh install, so if `node_modules` was populated before the override existed (or by a different package manager) the wrong webpack stays cached. Reinstall cleanly:

```bash
cd docs
rm -rf node_modules package-lock.json
npm install
npm run build
```

## Deployment

The site is configured for GitHub Pages with `baseUrl: /nebari-rayserve-pack/`. A GitHub Pages publishing workflow is not yet wired up; deployment is manual for now.
