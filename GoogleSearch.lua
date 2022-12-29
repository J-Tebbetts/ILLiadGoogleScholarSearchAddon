-- About GoogleSearch.lua
--
-- GoogleSearch.lua does a generic Google search for the LoanTitle for loans and the PhotoArticleTitle for articles.
-- autoSearch (boolean) determines whether the search is performed automatically when a request is opened or not.

-- Load the .NET System Assembly
luanet.load_assembly("System");
Types = {};
Types["Process"] = luanet.import_type("System.Diagnostics.Process");

local settings = {};
settings.AutoSearch = GetSetting("AutoSearch");


local interfaceMngr = nil;
local googleSearchForm = {};

require "Atlas.AtlasHelpers";

function Init()
	interfaceMngr = GetInterfaceManager();
	
	-- Create a form
	googleSearchForm.Form = interfaceMngr:CreateForm("Google Search", "Google Search");
	
	-- Add a browser
	googleSearchForm.Browser = googleSearchForm.Form:CreateBrowser("Google Search", "Google Search Browser", "Google Search", "WebView2");
	
	-- Hide the text label
	googleSearchForm.Browser.TextVisible = false;
	googleSearchForm.Browser:CollapseTextPlaceholder();
	
	-- Since we didn't create a ribbon explicitly before creating our browser, it will have created one using the name we passed the CreateBrowser method.  We can retrieve that one and add our buttons to it.
	googleSearchForm.RibbonPage = googleSearchForm.Form:GetRibbonPage("Google Search");
	
	-- Create the search button
	googleSearchForm.RibbonPage:CreateButton("Search", GetClientImage("Search32"), "Search", "Google");
	googleSearchForm.RibbonPage:CreateButton("Open New Browser", GetClientImage("Web32"), "OpenInDefaultBrowser", "Utility");
	

	-- After we add all of our buttons and form elements, we can show the form.
	googleSearchForm.Form:Show();

	-- Search when opened if autoSearch is true
	if settings.AutoSearch then
		Search();
	end
end

function Search()
	local searchText = nil;
	
	if GetFieldValue("Transaction", "RequestType") == "Loan" then
		searchText = GetFieldValue("Transaction", "LoanTitle");
    else
		searchText = GetFieldValue("Transaction", "PhotoArticleTitle");
    end
	
	googleSearchForm.Browser:Navigate("http://google.com/search?q=" .. AtlasHelpers.UrlEncode(searchText));
end

function OpenInDefaultBrowser()
	local currentUrl = googleSearchForm.Browser.Address;
	
	if (currentUrl and currentUrl ~= "")then
		LogDebug("Opening Browser URL in default browser: " .. currentUrl);

		local process = Types["Process"]();
		process.StartInfo.FileName = currentUrl;
		process.StartInfo.UseShellExecute = true;
		process:Start();
	end
end