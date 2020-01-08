package com.catDog.game;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("game.gameController")
public class GameController {
	
	@RequestMapping("/game/game")
	public String game() throws Exception {
		return ".game.game";
	}
}
