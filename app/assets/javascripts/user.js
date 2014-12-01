// $(document).ready(function() {
//     $('#userForm')
//         .bootstrapValidator({
//             feedbackIcons: {
//                 valid: 'glyphicon glyphicon-ok',
//                 invalid: 'glyphicon glyphicon-remove',
//                 validating: 'glyphicon glyphicon-refresh'
//             },
//             fields: {
//                 phoneNumber: {
//                     validators: {
//                         phone: {
//                             message: 'The value is not valid US phone number'
//                         }
//                     }
//                 }
//             }
//         })
//         // // Revalidate phone number when changing the country
//         // .on('change', '[name="countrySelectBox"]', function(e) {
//         //     $('#phoneForm').bootstrapValidator('revalidateField', 'phoneNumber');
//         // });
// });