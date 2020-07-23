({
    handleClick: function(component, event, helper) {
        console.log('handleClick');
        var btnClicked = event.getSource();         // the button
        var btnMessage = btnClicked.get("v.label"); // the button's label

        component.set("v.message", btnMessage);
        //console.log("v.message", component.get("v.message"));


        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": btnMessage,
            "type": "SUCCESS"
        });
        //toastEvent.fire();
        helper.showToastMessage(component); 
    }
});