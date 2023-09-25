function previewImage(input) {
    var preview = document.getElementById('preview');
    var displayPreview = document.getElementById('displayPreview');
    var fileInput = document.getElementById('fileInput');

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = 'block';

            displayPreview.src = e.target.result;
            displayPreview.style.display = 'block';
        };

        reader.readAsDataURL(input.files[0]);
    } else {
        preview.src = '';
        preview.style.display = 'none';

        displayPreview.src = '';
        displayPreview.style.display = 'none';
    }
}

function confirmAction() {
    var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการเพิ่มหลักสูตรนี้?");
    if (result) {
        return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
    } else {
        return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
    }
}

function displayDataInStep3() {
    // ข้อมูลจาก Step 1
    const courseType = document.getElementById("course_type").value;
    const courseName = document.getElementById("course_name").value;
    const certificateName = document.getElementById("certificateName").value;
    const major = document.getElementById("major_id").value;
    const course_principle = document.getElementById("floatingTextarea2").value;

    // ข้อมูลจาก Step 2
    const objectives = document.querySelectorAll("input[name='course_objectives[]']");
    const totalHours = document.getElementById("course_totalHours").value;
    const fee = document.getElementById("course_fee").value;
    const courseFile = document.getElementById("course_file").value;
    const targetOccupation = document.getElementById("floatingTextarea3").value;

    // แสดงข้อมูลใน Step 3
    document.getElementById("displayCourseType").textContent = courseType;
    document.getElementById("displayCourseName").textContent = courseName;
    document.getElementById("displayCertificateName").textContent = certificateName;
    document.getElementById("displayMajor").textContent = major;
    document.getElementById("displayCoursePrinciple").textContent = course_principle;
    document.getElementById("displayObjectives").textContent = Array.from(objectives).map(obj => obj.value).join(", ");
    document.getElementById("displayTotalHours").textContent = totalHours;
    document.getElementById("displayFee").textContent = fee;
    document.getElementById("displayCourseFile").textContent = courseFile;
    document.getElementById("displayTargetOccupation").textContent = targetOccupation;
}

// เรียกใช้ฟังก์ชันเมื่อคลิก Next ใน Step 2
document.getElementById("nextBtn").addEventListener("click", displayDataInStep3);

var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the current tab

function showTab(n) {
    // This function will display the specified tab of the form...
    var x = document.getElementsByClassName("step");
    x[n].style.display = "block";
    //... and fix the Previous/Next buttons:
    if (n == 0) {
        document.getElementById("prevBtn").style.display = "none";
    } else {
        document.getElementById("prevBtn").style.display = "inline";
    }
    if (n == (x.length - 1)) {
        document.getElementById("nextBtn").innerHTML = "Submit";
    } else {
        document.getElementById("nextBtn").innerHTML = "Next";
    }
    //... and run a function that will display the correct step indicator:
    fixStepIndicator(n)
}

function nextPrev(n) {
    // This function will figure out which tab to display
    var x = document.getElementsByClassName("step");
    // Exit the function if any field in the current tab is invalid:
    if (n == 1 && !validateForm()) return false;
    // Hide the current tab:
    x[currentTab].style.display = "none";
    // Increase or decrease the current tab by 1:
    currentTab = currentTab + n;
    // if you have reached the end of the form...
    if (currentTab >= x.length) {
        // ... the form gets submitted:
        document.getElementById("signUpForm").submit();
        return false;
    }
    // Otherwise, display the correct tab:
    showTab(currentTab);
}

function validateForm() {
    // This function deals with validation of the form fields
    var x, y, i, valid = true;
    x = document.getElementsByClassName("step");
    y = x[currentTab].getElementsByTagName("input");
    // A loop that checks every input field in the current tab:
    for (i = 0; i < y.length; i++) {
        // If a field is empty...
        if (y[i].value == "") {
            // add an "invalid" class to the field:
            y[i].className += " invalid";
            // and set the current valid status to false
            valid = false;
        }
    }
    // If the valid status is true, mark the step as finished and valid:
    if (valid) {
        document.getElementsByClassName("stepIndicator")[currentTab].className += " finish";
    }
    return valid; // return the valid status
}

function fixStepIndicator(n) {
    // This function removes the "active" class of all steps...
    var i, x = document.getElementsByClassName("stepIndicator");
    for (i = 0; i < x.length; i++) {
        x[i].className = x[i].className.replace(" active", "");
    }
    //... and adds the "active" class on the current step:
    x[n].className += " active";
}

function addObjective() {
    var container = document.getElementById('objectives-container');
    var objectiveContainer = document.createElement('div');
    objectiveContainer.className = 'objective-container';

    var objectiveInput = document.createElement('input');
    objectiveInput.type = 'text';
    objectiveInput.name = 'course_objectives[]';
    objectiveInput.className = 'objective';

    var removeButton = document.createElement('button');
    removeButton.type = 'button';
    removeButton.textContent = 'ลบ';
    removeButton.className = 'btn btn-danger';
    removeButton.onclick = function() {
        container.removeChild(objectiveContainer);
        updateRemoveButtons();
    };

    objectiveContainer.appendChild(objectiveInput);
    objectiveContainer.appendChild(removeButton);
    container.appendChild(objectiveContainer);
    updateRemoveButtons();
}

function updateRemoveButtons() {
    var containers = document.getElementsByClassName('objective-container');
    var removeButtons = document.querySelectorAll('.objective-container button.btn-danger');

    if (containers.length === 1) {
        for (var i = 0; i < removeButtons.length; i++) {
            removeButtons[i].style.display = 'none';
        }
    } else {
        for (var i = 0; i < removeButtons.length; i++) {
            removeButtons[i].style.display = 'block';
        }
    }
}

function removeObjective(button) {
    var container = document.getElementById('objectives-container');
    var objectiveContainer = button.parentNode;

    if (container.getElementsByClassName('objective-container').length > 1) {
        container.removeChild(objectiveContainer);
    } else {
        alert('คุณไม่สามารถลบวัตถุประสงค์ได้อีก');
    }

    updateRemoveButtons();
}