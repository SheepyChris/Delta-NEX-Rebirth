local TIMER_SECONDS = THEME:GetMetric("LoadingScreen", "TimerSeconds")
if not TIMER_SECONDS then TIMER_SECONDS = 5 end;

--Make this global so ScreenSelectMusic in can see it too
randomBackground = getRandomBackground("_random wallpapers");
local t = Def.ActorFrame{


	LoadActor(randomBackground)..{
		InitCommand=cmd(Cover);
	};
	
	LoadActor(THEME:GetPathG("", "logo/delta rebirth"))..{
		InitCommand=cmd(zoom,.25;xy,SCREEN_WIDTH*.2,SCREEN_BOTTOM*.8;);
		OnCommand=function(self)
			--SCREENMAN:SystemMessage(getRandomBackground("_random wallpapers"));
			self:sleep(TIMER_SECONDS)
			self:queuecommand("GoNextScreen");
		end;
		GoNextScreenCommand=function(self)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen");
		end;
	};
	
};

return t;
