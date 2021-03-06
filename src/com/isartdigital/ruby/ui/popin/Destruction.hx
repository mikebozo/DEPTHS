package com.isartdigital.ruby.ui.popin;

import com.isartdigital.ruby.game.world.MapInteractor;
import com.isartdigital.ruby.ui.hud.InfosBatiment;
import com.isartdigital.ruby.ui.popin.contextual.BuildingContextualMenu;
import com.isartdigital.utils.events.MouseEventType;
import com.isartdigital.utils.events.TouchEventType;
import com.isartdigital.utils.sounds.SoundManager;
import com.isartdigital.utils.ui.smart.SmartButton;
import com.isartdigital.utils.ui.smart.SmartPopin;

/**
 * ...
 * @author Adrien Bourdon
 */
class Destruction extends SmartPopinRegister
{

	/**
	 * instance unique de la classe Destruction
	 */
	private static var instance: Destruction;
	private static inline var YES_BTN:String = "btn_Yes";
	private static inline var NO_BTN:String = "btn_No";

	private var yesButton:SmartButton;
	private var noButton:SmartButton;

	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): Destruction
	{
		if (instance == null) instance = new Destruction();
		return instance;
	}

	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new(pID:String=null)
	{
		super(pID);
		yesButton = cast(getChildByName(YES_BTN),SmartButton);
		noButton = cast(getChildByName(NO_BTN), SmartButton);

		yesButton.on(MouseEventType.CLICK, onYes);
		noButton.on(MouseEventType.CLICK, onNo);

		yesButton.on(TouchEventType.TAP, onYes);
		noButton.on(TouchEventType.TAP, onNo);
	}

	private function onYes()
	{
		
		BuildingContextualMenu.getInstance().isDestroyConfirmed();
		UIManager.getInstance().closeCurrentPopin();
		MapInteractor.getInstance().closeInfoPanel();
		SoundManager.getSound("removeBuilding").play();
		SmartPopinRegister.event.emit("onYes");
	}

	private function onNo()
	{
		UIManager.getInstance().closeCurrentPopin();
	}

	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	override public function destroy (): Void
	{
		yesButton.off(MouseEventType.CLICK, onYes);
		noButton.off(MouseEventType.CLICK, onNo);

		yesButton.off(TouchEventType.TAP, onYes);
		noButton.off(TouchEventType.TAP, onNo);

		instance = null;
		super.destroy();
	}

}