pudge_rot_lua = class({})
LinkLuaModifier( "modifier_rot_lua", "abilities/pudge/modifiers/modifier_rot_lua.lua" ,LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_rot_silence_lua", "abilities/pudge/modifiers/modifier_rot_silence_lua.lua" ,LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_rot_silence_stack_lua", "abilities/pudge/modifiers/modifier_rot_silence_stack_lua.lua" ,LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_silence_lua", "abilities/pudge/modifiers/modifier_silence_lua.lua" ,LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_status_resistance_lua", "abilities/pudge/modifiers/modifier_status_resistance_lua.lua" ,LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function pudge_rot_lua:ProcsMagicStick()
	return false
end

--------------------------------------------------------------------------------

function pudge_rot_lua:OnToggle()
	-- Apply the rot modifier if the toggle is on
	if self:GetToggleState() then
		self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rot_lua", nil )
		
		local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_pudge_4")
		local talent_silence = self:GetCaster():FindAbilityByName("special_bonus_unique_pudge_7")

		if talent and talent:GetLevel() > 0 then
			self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_status_resistance_lua", nil )
		end
		
		if talent_silence and talent_silence:GetLevel() > 0 then
			self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_rot_silence_lua", nil )
		end
		
		if not self:GetCaster():IsChanneling() then
			self:GetCaster():StartGesture( ACT_DOTA_CAST_ABILITY_ROT )
		end
	else
		-- Remove it if it is off
		local hRotBuff = self:GetCaster():FindModifierByName( "modifier_rot_lua" )
		local hRotStatus = self:GetCaster():FindModifierByName( "modifier_status_resistance_lua" )
		local hRotSilence= self:GetCaster():FindModifierByName( "modifier_rot_silence_lua" )
		
		if hRotBuff ~= nil then
			hRotBuff:Destroy()
		end
		if hRotStatus ~= nil then
			hRotStatus:Destroy()
		end
		if hRotSilence ~= nil then
			hRotSilence:Destroy()
		end
	end
end

--------------------------------------------------------------------------------