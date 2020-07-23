({
    showToastMessage: function (component) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": component.get("v.message"),
            "type": "SUCCESS"
        });
        toastEvent.fire();
    }
});