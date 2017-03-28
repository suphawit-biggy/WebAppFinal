<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Monster Battle</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>

</head>
<body ng-app="myApp" class="ng-cloak">
	<div class="generic-container" ng-controller="MonsterController as ctrl">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span class="lead" ng-show="ctrl.battlemode.state === 0">Monster Registration Form</span> 
				<span class="lead" ng-show="ctrl.battlemode.state === 1"><center>Select Your First Monster</center></span> 
				<span class="lead" ng-show="ctrl.battlemode.state === 2"><center>Select Your Second Monster</center></span> 
				<span class="lead" ng-show="ctrl.battlemode.state === 3"><center>Ready to Fight</center></span>
			</div>
			<div class="formcontainer" ng-show="ctrl.battlemode.state === 0">
				<form ng-submit="ctrl.submit()" name="myForm" class="form-horizontal">
					<input type="hidden" ng-model="ctrl.monster.id" />
					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="mname">Name</label>
							<div class="col-md-7">
								<input type="text" ng-model="ctrl.monster.monstername"
									name="mname" class="monstername form-control input-sm"
									placeholder="Enter monster's name" required ng-minlength="3" />
								<div class="has-error" ng-show="myForm.manme.$dirty">
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.required">This is a required field</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.minlength">Minimum length required is 3</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$invalid">This field is invalid </span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="health">Health</label>
							<div class="col-md-7">
								<input type="number" ng-model="ctrl.monster.health"
									name="health" class="health form-control input-sm"
									placeholder="Enter monster's Health." required min="1" />
								<div class="has-error" ng-show="myForm.health.&dirty">
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.required">This is a required field</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.min">Minimum value required is 1</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$invalid">This field is invalid </span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="attack">Attack</label>
							<div class="col-md-7">
								<input type="number" ng-model="ctrl.monster.attack"
									name="attack" class="health form-control input-sm"
									placeholder="Enter monster's Attack." required min="1" />
								<div class="has-error" ng-show="myForm.attack.$dirty">
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.required">This is a required field</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.min">Minimum value required is 1</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$invalid">This field is invalid </span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-group col-md-12">
							<label class="col-md-2 control-lable" for="speed">Speed</label>
							<div class="col-md-7">
								<input type="number" ng-model="ctrl.monster.speed" 
									name="speed" class="health form-control input-sm"
									placeholder="Enter monster's Speed." required min="1" />
								<div class="has-error" ng-show="myForm.speed.$dirty">
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.required">This is a required field</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$error.min">Minimum value required is 1</span> 
									<span ng-show="myForm.manme.$dirty && myForm.manme.$invalid">This field is invalid </span>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="form-actions floatRight">
							<input type="submit" value="{{!ctrl.monster.id ? 'Add' : 'Update'}}"
								class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
							<button type="button" ng-click="ctrl.reset()"
								class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">
								Reset Form</button>
							<button type="button" ng-disabled="ctrl.monsters.length < 2" 
								class="btn btn btn-danger btn-sm" ng-click="ctrl.enterBattleMode()">
								Battle Mode</button>
						</div>
					</div>
				</form>
			</div>

			<div class="battlecontainer" ng-show="ctrl.battlemode.state === 3">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>ID.</th>
							<th>Name</th>
							<th>Health</th>
							<th>Attack</th>
							<th>Speed</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><span ng-bind="ctrl.battleMonster1.id"></span></td>
							<td><span ng-bind="ctrl.battleMonster1.monstername"></span></td>
							<td><span ng-bind="ctrl.battleMonster1.health"></span></td>
							<td><span ng-bind="ctrl.battleMonster1.attack"></span></td>
							<td><span ng-bind="ctrl.battleMonster1.speed"></span></td>
						</tr>
						<tr>
							<td><span ng-bind="ctrl.battleMonster2.id"></span></td>
							<td><span ng-bind="ctrl.battleMonster2.monstername"></span></td>
							<td><span ng-bind="ctrl.battleMonster2.health"></span></td>
							<td><span ng-bind="ctrl.battleMonster2.attack"></span></td>
							<td><span ng-bind="ctrl.battleMonster2.speed"></span></td>
						</tr>
				</table>
				<div class="form-actions floatRight">
					<span ng-show="ctrl.winner !== null" ng-bind="ctrl.winner.monstername"></span>
					<span ng-show="ctrl.winner !== null"> is the winner!</span>
					<button type="button" ng-click="ctrl.fight()"
						class="btn btn btn-danger btn-sm" ng-hide="ctrl.winner !== null">
						Fight!</button>
					<button type="button" ng-click="ctrl.backOriginalState()"
						class="btn btn btn-danger btn-sm" ng-show="ctrl.winner !== null">
						Finish</button>
				</div>
			</div>

			<div class="panel panel-default" ng-hide="ctrl.battlemode.state === 3">
				<!-- Default panel contents -->
				<div class="panel-heading">
					<span class="lead">List of Monsters </span>
				</div>
				<div class="tablecontainer">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>ID.</th>
								<th>Name</th>
								<th>Health</th>
								<th>Attack</th>
								<th>Speed</th>
								<th width="20%"></th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="m in ctrl.monsters">
								<td><span ng-bind="m.id"></span></td>
								<td><span ng-bind="m.monstername"></span></td>
								<td><span ng-bind="m.health"></span></td>
								<td><span ng-bind="m.attack"></span></td>
								<td><span ng-bind="m.speed"></span></td>
								<td>
									<button type="button" ng-click="ctrl.edit(m.id)"
										class="btn btn-success custom-width" ng-hide="ctrl.isSelectState()">
										Edit</button>
									<button type="button" ng-click="ctrl.remove(m.id)"
										class="btn btn-danger custom-width" ng-hide="ctrl.isSelectState()">
										Remove</button>
									<button type="button" ng-click="ctrl.selectMonster(m.id)"
										class="btn btn-success custom-width" ng-show="ctrl.isSelectState()">
										Select</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<script
			src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
		<script src="<c:url value='/static/js/app.js' />"></script>
		<script
			src="<c:url value='/static/js/controller/monster_controller.js' />"></script>
		<script src="<c:url value='/static/js/service/monster_service.js' />"></script>
</body>
</html>