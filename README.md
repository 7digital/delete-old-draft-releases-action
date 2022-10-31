# Delete Old Draft Releases Action

Action to delete draft releases older than a specific release.

## Inputs

### `github-token` (required)

GitHub token access the GitHub API. Requires read and write access to the repository above.

### `release-id` (required)

The GitHub release up to which draft releases will be deleted, i.e. any drafts older than this release will be deleted.

### `github-api-url`

GitHub API to use. Defaults to API URL on the `github` context.

### `github-repo`

GitHub repository to use. Defaults to the repository on the `github` context.

## Example

```yml
on:
  release:
    types: [published]

jobs:
  delete-drafts:
    runs-on: ubuntu-latest
    steps:
      - uses: 7digital/delete-old-draft-releases
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          release-id: ${{ github.event.release.id }}
```
