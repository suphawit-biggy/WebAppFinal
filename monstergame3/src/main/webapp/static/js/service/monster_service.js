'use strict';

App.factory('MonsterService', [ '$http', '$q', function($http, $q) {

	return {

		fetchAllMonsters : function() {
			var targetURI = 'http://localhost:8080/monstergame3/monster/';
			return $http.get(targetURI).then(function(response) {
				return response.data;
			}, function(errResponse) {
				console.error('Error while fetching monsters');
				alert('Error while fetching monsters ' + targetURI);
				return $q.reject(errResponse);
			});
		},

		createMonster : function(monster) {
			var targetURI = 'http://localhost:8080/monstergame3/monster/';
			return $http.post(targetURI, monster).then(function(response) {
				return response.data;
			}, function(errResponse) {
				console.error('Error while creating monster');
				alert('Error while creating monster ' + targetURI);
				return $q.reject(errResponse);
			});
		},

		updateMonster : function(monster, id) {
			var targetURI = 'http://localhost:8080/monstergame3/monster/' + id;
			return $http.put(targetURI, monster).then(function(response) {
				return response.data;
			}, function(errResponse) {
				console.error('Error while updating monster');
				alert('Error while updating monster ' + targetURI);
				return $q.reject(errResponse);
			});
		},

		deleteMonster : function(id) {
			var targetURI = 'http://localhost:8080/monstergame3/monster/'+ id;
			return $http.delete(targetURI).then(function(response) {
				return response.data;
			}, function(errResponse) {
				console.error('Error while deleting monster');
				alert('Error while deleting monster ' + targetURI);
				return $q.reject(errResponse);
			});
		}

	};

} ]);