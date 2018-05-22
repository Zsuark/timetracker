({
    doInit : function(component, event, helper) {
        var action = component.get("c.getProjectForCurrentUser");
        console.log("action: " + action);
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("response: " + JSON.stringify(response));
            console.log("state: " + state);
            if (state === "SUCCESS") {
                var returnVal = response.getReturnValue();
                console.log('projects returned: ' + JSON.stringify(returnVal));
                component.set("v.projects", returnVal);
            }
            else {
                if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        console.log('errors: ' + JSON.stringify(errors));
                    } else {
                        console.log("Unknown error");
                    }
                }
                console.log("projectHeader doInit failed with state: " + state);
            }
        })
        
        $A.enqueueAction(action);
    }
})