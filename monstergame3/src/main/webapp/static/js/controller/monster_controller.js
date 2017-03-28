'use strict';

App.controller('MonsterController', [ '$scope', 'MonsterService', function($scope, MonsterService) {
			var self = this;
			self.monster = {
				id : null,
				monstername : '',
				health : '',
				attack : '',
				speed : ''
			};
			self.monsters = [];

			self.fetchAllMonsters = function() {
				MonsterService.fetchAllMonsters().then(function(d) {
					self.monsters = d;
				}, function(errResponse) {
					console.error('Error while fetching Monsters');
				});
			};

			self.createMonster = function(monster) {
				MonsterService.createMonster(monster).then(self.fetchAllMonsters, function(errResponse) {
					console.error('Error while creating Monster.');
				});
			};

			self.updateMonster = function(monster, id) {
				MonsterService.updateMonster(monster, id).then(self.fetchAllMonsters, function(errResponse) {
					console.error('Error while updating Monster.');
				});
			};

			self.deleteMonster = function(id) {
				MonsterService.deleteMonster(id).then(self.fetchAllMonsters,function(errResponse) {
					console.error('Error while deleting Monster.');
				});
			};

			self.fetchAllMonsters();

			self.submit = function() {
				if (self.monster.id === null) {
					console.log('Saving New Monster', self.monster);
					self.createMonster(self.monster);
				} else {
					self.updateMonster(self.monster, self.monster.id);
					console.log('Monster updated with id ', self.monster.id);
				}
				console.log(id);
				self.reset();
			};

			self.edit = function(id) {
				console.log('id to be edited', id);
				for (var i = 0; i < self.monsters.length; i++) {
					if (self.monsters[i].id === id) {
						self.monster = angular.copy(self.monsters[i]);
						break;
					}
				}
			};

			self.remove = function(id) {
				console.log('id to be deleted', id);
				if (self.monster.id === id) {
					self.reset();
				}
				self.deleteMonster(id);
			};

			self.reset = function() {
				self.monster = {
					id : null,
					monstername : '',
					health : '',
					attack : '',
					speed : ''
				};
				$scope.myForm.$setPristine();
			};

			self.StateEnum = {
				EDIT : 0,
				SELECT1 : 1,
				SELECT2 : 2,
				BATTLE : 3
			}
			
			self.battlemode = {
					"state" : self.StateEnum.EDIT
			};

			self.incrementState = function() {
				self.battlemode.state = (self.battlemode.state + 1) % Object.keys(self.StateEnum).length;
			}
			
			self.battleMonster1 = {
				id : null,
				monstername : '',
				health : '',
				attack : '',
				speed : ''
			};

			self.battleMonster2 = {
				id : null,
				monstername : '',
				health : '',
				attack : '',
				speed : ''
			};


			self.winner = null;
			self.healthB4Battle = null;

			self.fight = function() {
				var winner = null;
				var first = null;
				var second = null;
				self.healthB4Battle = self.battleMonster1.health;
				if (self.battleMonster1.speed >= self.battleMonster2.speed) {
					first = self.battleMonster1;
					second = self.battleMonster2;
				} else {
					first = self.battleMonster2;
					second = self.battleMonster1;
				}

				do {
					second.health = second.health - first.attack;
					if (second.health <= 0) {
						second.health = 0;
						winner = first;
						break;
					}
					first.health = first.health - second.attack;
					if (first.health <= 0) {
						first.health = 0;
						winner = second;
						break;
					}
				} while (!winner) {
					self.winner = winner;
				}
			};

			self.backOriginalState = function() {
				self.battleMonster1.health = self.healthB4Battle;
				self.createMonster(self.battleMonster1);
				self.winner = null;
				self.incrementState();
				document.body.style.backgroundColor = "rgb(245, 245, 245)";
			}

			self.isSelectState = function() {
				if (self.battlemode.state === 1 || self.battlemode.state === 2) {
					return true;
				} else {
					return false;
				}
			};

			self.enterBattleMode = function() {
				document.body.style.backgroundColor = "#d43f3a";
				self.incrementState();
			};

			self.selectMonster = function(id) {
				console.log('Monster selected', id);
				for (var i = 0; i < self.monsters.length; i++) {
					if (self.monsters[i].id === id) {
						if (self.battlemode.state === 1) {
							self.battleMonster1 = angular.copy(self.monsters[i]);
							self.remove(id);
						} else {
							self.battleMonster2 = angular.copy(self.monsters[i]);
						}
						break;
					}
				}
				self.incrementState();
			};

		} ]);