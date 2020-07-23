({
    handleCmpEvent: function(cmp, event, helper) {
        var message = event.getParam("message");

        if (message) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                message: message
            });
            toastEvent.fire();
        }
    }
})