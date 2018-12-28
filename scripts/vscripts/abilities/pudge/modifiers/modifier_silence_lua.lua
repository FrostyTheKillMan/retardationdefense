modifier_silence_lua = class({})
--------------------------------------------------------------------------------

function modifier_silence_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_silence_lua:IsHidden()
	return false
end

--------------------------------------------------------------------------------

function modifier_silence_lua:GetTexture()
    return 'pudge_rot'
end

--------------------------------------------------------------------------------

function modifier_silence_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end



