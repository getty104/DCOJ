module Resonatable
	include Resonance
	resonate :user, target: :user, action: :follow
	resonate :user, target: :user, action: :block
end