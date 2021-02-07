
 
$(function () {
    function display(bool) {
        if (bool) {
            $(".form").show();
        } else {
            $(".form").hide();
        }
    }

    function displayWanted(bool) {
        if (bool) {
            $("#boxBackground").show();
        } else {
            $("#boxBackground").hide();
        }
    }

    displayWanted(false)
    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        var audioPlayer = null;

        // Check for playSound transaction
        if (event.data.transactionType == "playSound") {
        
            if (audioPlayer != null) 
            {
                audioPlayer.pause();
            }

            audioPlayer = new Howl({src: ["./sounds/" + event.data.transactionFile + ".ogg"]});
            audioPlayer.volume(event.data.transactionVolume);
            audioPlayer.play();
        }


        if (item.type === "enableui") {
            if (item.activate == true) {
                display(true)
            } else {
                display(false)
            }
        }

        if (item.type === "wantedAnnouce") {
            if (item.activate == true) {
                displayWanted(true)
                $(".FirstName").text(event.data.firstName);
                $(".SecondName").text(event.data.lastName);
                $(".reason").text(event.data.dataReason);
            } else {
                displayWanted(false)
            }
        }
    })

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://GTA_Wanted/exit', JSON.stringify({}));
            return
        }
    };
 
    //when the user clicks on the submit button, it will run
    $("#tr_validate").click(function () {
        let vfirstName = $("#tr_fNameHolder").val();
        let vlastName = $("#tr_lNameHolder").val();
        let vReason = $("#tr_reasonHolder").val();

        //Check for first name input : 
        if (!vfirstName) {
            $.post("http://GTA_Wanted/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }

        //Check for last name input : 
        if (!vlastName) {
            $.post("http://GTA_Wanted/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }

        //Check for last name input : 
        if (!vReason) {
            $.post("http://GTA_Wanted/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }

        $.post("http://GTA_Wanted/main", JSON.stringify({
            fName: vfirstName,
            lName: vlastName,
            vreason : vReason
        }))
        return;
    })
})