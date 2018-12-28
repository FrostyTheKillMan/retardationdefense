modifier_rot_silence_lua = class({})
--------------------------------------------------------------------------------

function modifier_rot_silence_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:IsAura()
	if self:GetCaster() == self:GetParent() then
		return true
	end
	
	return false
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:GetModifierAura()
	return "modifier_rot_silence_lua"
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:GetAuraRadius()
	return self.rot_radius
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:OnCreated( kv )
	self.rot_radius = self:GetAbility():GetSpecialValueFor( "rot_radius" )
	self.rot_tick = 1.0
	
	if IsServer() then
		self:StartIntervalThink( self.rot_tick )
	end
end

--------------------------------------------------------------------------------

function modifier_rot_silence_lua:OnIntervalThink()
	if IsServer() then
		if self:GetCaster() ~= self:GetParent() then
		
			local hBuff = self:GetParent():FindModifierByName( "modifier_rot_silence_stack_lua" )
			
			if hBuff ~= nil then
				hBuff:SetStackCount( hBuff:GetStackCount() + 1 )
			else 
				self:GetParent():AddNewModifier( self:GetCaster(), self, "modifier_rot_silence_stack_lua", { duration = 8 } )
			end
			
			if hBuff ~= nil then
				if hBuff:GetStackCount() > 2 then
					self:GetParent():AddNewModifier( self:GetCaster(), self, "modifier_silence_lua", { duration = 3 } )
					self:GetParent():RemoveModifierByName("modifier_rot_silence_stack_lua")
				end
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------