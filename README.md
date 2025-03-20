# Get next tag action

This action returns the bumped up tag

## Intputs

## `release-type`

**Required** The release type can be: Major, Minor, or HotFix

## `current-tag`

The tag found in the repository. Default value is ''

## Outputs

## `next-tag`

The bumped up input tag.

If the current-tag is '' or omitted, the next tag will be '`1.0.0`' regardless of the release-type value.

If the release-type is 'Major' and the current-tag is '2', the next-tag will be '`3`'.

If the release-type is 'Minor' and the current-tag is 'v2', the next-tag will be '`v2.1`'.

If the release-type is 'HotFix' and the current-tag is 'v2', the next-tag will be '`v2.0.1`'.

## Example usage

uses: wtout/get-next-tag-action@v6

with:

	release-type: Major

	current-tag: 1.0.0
