-- About GoogleSearch.lua
--
-- GoogleSearch.lua does a generic Google search for the LoanTitle for loans and the PhotoArticleTitle for articles.
-- autoSearch (boolean) determines whether the search is performed automatically when a request is opened or not.

local settings = {};
settings.AutoSearch = GetSetting("AutoSearch");

local interfaceMngr = nil;
local googleSearchForm = {};
googleSearchForm.Form = nil;
googleSearchForm.Browser = nil;
googleSearchForm.RibbonPage = nil;

require "Atlas.AtlasHelpers";

function Init()
	interfaceMngr = GetInterfaceManager();
	
	-- Create a form
	googleSearchForm.Form = interfaceMngr:CreateForm("Google Search", "Script");
	
	-- Add a browser
	googleSearchForm.Browser = googleSearchForm.Form:CreateBrowser("Google Search", "Google Search Browser", "Google Search");
	
	-- Hide the text label
	googleSearchForm.Browser.TextVisible = false;
	
	-- Since we didn't create a ribbon explicitly before creating our browser, it will have created one using the name we passed the CreateBrowser method.  We can retrieve that one and add our buttons to it.
	googleSearchForm.RibbonPage = googleSearchForm.Form:GetRibbonPage("Google Search");
	
	-- Create the search button
	googleSearchForm.RibbonPage:CreateButton("Search", GetClientImage("Search32"), "Search", "Google");
	
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

