modifier_rot_silence_stack_lua = class({})
--------------------------------------------------------------------------------

function modifier_rot_silence_stack_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_rot_silence_stack_lua:IsHidden()
	return false
end

--------------------------------------------------------------------------------

function modifier_rot_silence_stack_lua:GetTexture()
    return 'pudge_rot'
end

--------------------------------------------------------------------------------