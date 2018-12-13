-- About GoogleSearch.lua
--
-- GoogleSearch.lua does a generic Google search for the LoanTitle for loans and the PhotoArticleTitle for articles.
-- autoSearch (boolean) determines whether the search is performed automatically when a request is opened or not.
--
-- "f" is the formname on google.com
-- "q" is the text box name on google.com

local autoSearch = GetSetting("AutoSearch");

local interfaceMngr = nil;
local browser = nil;

function Init()
	LogDebug("Script initialized dustin");
	interfaceMngr = GetInterfaceManager();
	
	-- Create browser		
	browser = interfaceMngr:CreateBrowser("Google Search", "Google Search", "Script");
	
	-- Create buttons
	browser:CreateButton("Search", GetClientImage("Search32"), "Search", "Google");
	
	browser:Show();
	
	-- Search when opened if autoSearch is true
	if autoSearch then
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
	
	browser:Navigate("http://google.com/search?q=" .. searchText);	
end

