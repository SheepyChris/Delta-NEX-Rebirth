-- To add a section to the credits, use the following:
-- local theme_credits= {
-- 	name= "Theme Credits", -- the name of your section
-- 	"Me", -- The people you want to list in your section.
-- 	"Myself",
-- 	"My other self",
--  {logo= "pro_dude", name= "Pro self"}, -- Someone who has a logo image.
--     -- This logo image would be "Graphics/CreditsLogo pro_dude.png".
-- }
-- StepManiaCredits.AddSection(theme_credits)
--
-- If you want to add your section after an existing section, use the following:
-- StepManiaCredits.AddSection(theme_credits, 7)
--
-- Or position can be the name of a section to insert after:
-- StepManiaCredits.AddSection(theme_credits, "Special Thanks")
--
-- Or if you want to add your section before a section:
-- StepManiaCredits.AddSection(theme_credits, "Special Thanks", true)

-- StepManiaCredits is defined in _fallback/Scripts/04 CreditsHelpers.lua.

local line_on = cmd(zoom,0.875;strokecolor,color("#444444");shadowcolor,color("#444444");shadowlength,1)
local section_on = cmd(diffuse,color("#88DDFF");strokecolor,color("#446688");shadowcolor,color("#446688");shadowlength,1)
local subsection_on = cmd(diffuse,color("#88DDFF");strokecolor,color("#446688");shadowcolor,color("#446688");shadowlength,1)
local item_padding_start = 500;
local line_height= 30
-- Tell the credits table the line height so it can use it for logo sizing.
StepManiaCredits.SetLineHeight(line_height)

local creditScroller = Def.ActorScroller {
	SecondsPerItem = 0.5;
	NumItemsToDraw = 40;
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:y(line_height*offset)
	end;
	OnCommand = cmd(scrollwithpadding,item_padding_start,15;Center);
}

-- Add sections with padding.
for section in ivalues(StepManiaCredits.Get()) do
	StepManiaCredits.AddLineToScroller(creditScroller, section.name, section_on)
	for name in ivalues(section) do
		if name.type == "subsection" then
			StepManiaCredits.AddLineToScroller(creditScroller, name, subsection_on)
		else
			StepManiaCredits.AddLineToScroller(creditScroller, name, line_on)
		end
	end
	StepManiaCredits.AddLineToScroller(creditScroller)
	StepManiaCredits.AddLineToScroller(creditScroller)
end



creditScroller.BeginCommand=function(self)
	SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', (creditScroller.SecondsPerItem * (#creditScroller + item_padding_start) + 5) );
    --SCREENMAN:GetTopScreen():PostScreenMessage('SM_MenuTimer', 116);
end;

return Def.ActorFrame{
	
	LoadActor(THEME:GetPathG("","_VIDEOS/back"))..{
		InitCommand=cmd(FullScreen;Center;diffusealpha,.5);
		OffCommand=cmd(accelerate,3;zoom,25;queuecommand,"StopMusic");
		StopMusicCommand=function(self)
			GAMESTATE:ApplyGameCommand("stopmusic");
		end;
	};
	
	
	LoadFont("Common Normal")..{
		Text="Pump It Up: Delta NEX Rebirth";
		InitCommand=cmd(Center);
		OnCommand=cmd(sleep,7;linear,.5;diffusealpha,0);
	};
	
	LoadFont("Common Normal")..{
		Text="By Rhythm Lunatic";
		InitCommand=cmd(Center;diffusealpha,0);
		OnCommand=function(self)
			self:sleep(7.5):linear(.5):diffusealpha(1);
		end;
	};
	
	creditScroller..{
		--InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-64);
        OnCommand=cmd(sleep,creditScroller.SecondsPerItem * (#creditScroller + item_padding_start) + 3;linear,1;diffusealpha,0);
	};

	LoadFont("venacti/_venacti 26px bold diffuse")..{
		Text="Thank You For Playing!";
		InitCommand=cmd(Center;diffusebottomedge,Color("Blue");shadowcolor,color("#000000");shadowlength,1;fadeleft,1;faderight,1;diffusealpha,0);
		OffCommand=cmd(linear,1;diffusealpha,1;fadeleft,0;faderight,0);
	}
};
