modifier_fury_swipes_lua = class({})

--------------------------------------------------------------------------------

function modifier_fury_swipes_lua:IsHidden()
	return true
end

function modifier_fury_swipes_lua:IsDebuff()
	return false
end

function modifier_fury_swipes_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_fury_swipes_lua:OnCreated( kv )
	if IsServer() then
		-- get reference
		self.reset_time = self:GetAbility():GetSpecialValueFor("reset_time")
		self.reset_time_roshan = self:GetAbility():GetSpecialValueFor("reset_time_roshan")
		
		local talent = self:GetAbility():GetCaster():FindAbilityByName("special_bonus_unique_ursa_3")
	
		if talent and talent:GetLevel() > 0 then
			self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
			self.damage_per_stack = self.damage_per_stack + talent:GetSpecialValueFor( "value" ) 
		else 
			self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
		end
	end
end

function modifier_fury_swipes_lua:OnRefresh( kv )
	if IsServer() then
		-- get reference
		self.reset_time = self:GetAbility():GetSpecialValueFor("reset_time")
		self.reset_time_roshan = self:GetAbility():GetSpecialValueFor("reset_time_roshan")
		
		local talent = self:GetAbility():GetCaster():FindAbilityByName("special_bonus_unique_ursa_3")
		
		if talent and talent:GetLevel() > 0 then
			self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
			self.damage_per_stack = self.damage_per_stack + talent:GetSpecialValueFor( "value" ) 
		else 
			self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
		end
	end
end
--------------------------------------------------------------------------------

function modifier_fury_swipes_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_fury_swipes_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- get target
		local target = params.target if target==nil then target = params.unit end
		if target:GetTeamNumber()==self:GetParent():GetTeamNumber() then
			return 0
		end

		-- get modifier stack
		local stack = 0
		local modifier = target:FindModifierByNameAndCaster("modifier_fury_swipes_debuff_lua", self:GetAbility():GetCaster())

		-- add stack if not
		if modifier==nil then
			-- if does not have break
			if not self:GetParent():PassivesDisabled() and not target:IsBuilding() then
				-- determine duration if roshan/not
				local duration_time = self.reset_time
				if params.target:GetUnitName()=="npc_dota_roshan" then
					duration_time = self.reset_time_roshan
				end

				-- add modifier
				print(duration_time)
				modifier = target:AddNewModifier( self:GetAbility():GetCaster(), self:GetAbility(), "modifier_fury_swipes_debuff_lua", { duration = duration_time })

				-- get stack number
				stack = 1
				
			end
		else
			-- increase stack
			modifier:IncrementStackCount()
			modifier:ForceRefresh()

			-- get stack number
			stack = modifier:GetStackCount()
		end

		-- return damage bonus
		return stack * self.damage_per_stack
	end
end