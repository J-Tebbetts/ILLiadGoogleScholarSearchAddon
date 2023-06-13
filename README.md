# ILLiad Google Search Addon

## Version

- 2.2.1
    - Added support to fall back to Chromium if WebView2 is unavailable

- 2.2.0
    - Updated addon to use the WebView2 (Edge-based) browser

- 2.1.0:

    - Added support to open the current URL with the default browser

- 2.0.0:

    - Added support for chromium-based browser

- 1.1:

    - Initial version of addon

## Summary
This addon is an ILLiad client addon that performs a generic Google search for the LoanTitle for loans and the PhotoArticleTitle for articles. 

The addon will display on request forms. 

## Installation

Visit the [addon documentation](https://atlas-sys.atlassian.net/wiki/spaces/ILLiadAddons/pages/3149384/Installing+Addons) for more information on installing ILLiad client addons.

### Dependencies 

This addon has dependencies:

* ILLiad 9.2 or above
    * In ILLiad 9.2.4 or above the addon will use the WebView2 embedded browser instead of Chromium

This addon can be used with earlier versions of ILLiad, but it will display in an IE-based browser and may not be fully functional.

*    Atlas Helpers

Ensure that Atlas Helpers is installed.

## Settings

### AutoSearch
Defines whether the search should be automatically performed when the form opens. Default value is "*true*"