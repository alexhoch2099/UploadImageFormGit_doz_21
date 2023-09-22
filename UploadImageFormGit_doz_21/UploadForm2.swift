//
//  UploadForm2.swift
//  UploadImageFormGit_doz_21
//
//  Created by Student on 22.09.23.
//

import SwiftUI

struct UploadForm2: View {
    
    @ObservedObject var dc:DataController = DataController()
    
    // show image picker
    @State var showImagePicker: Bool = false
    
    // show selected image
    @State var selectedImage: Image? = Image("")
    
    @State var filenameTxt:String = ""
    
    var body: some View {
        VStack{
            
            TextField("insert image name",text: $filenameTxt).onAppear{
                filenameTxt = ""
            }
            
            //------------öffnen picker----------------------------/
            Button(action: {
                
                self.showImagePicker.toggle()
                
            }, label: {
                Text("Select image")
            })
            
            //SICHTBARE IMAGE .. WIRD AUTOMATISCH ANGEZEIGT WENN DER IMAGEPICKER ETWAS ZURÜCKGIBT ...NACH AUSWAHL
           self.selectedImage?.resizable().scaledToFit()
            
            
            //--------------Bild an DataController schicken---------------------------------/
            
            Button(action: {
                //zeige nach frücken des upload buttons loadanimation oder text an
                dc.responseStr = "upload in progress ....."
                
                let uiImage: UIImage = self.selectedImage.asUIImage()
                
                //check ob neuer dateiname eingegeben wurde
                dc.uploadToServer(uiImage: uiImage,filename:filenameTxt)
                
                
                
            }, label: {
                Text("upload")
            })
            //------------------------------------------------------/
            
        }.sheet(isPresented: $showImagePicker, content: {
            //benutze die mitgelieferte struct struct ImagePicker: UIViewControllerRepresentable
            
            ImagePicker(image: self.$selectedImage.onChange(imageSelected))
            
            //Text("fgfg")
        })
        //Antwort vom Server anzeigen
        Text(dc.responseStr)
    }
    
    func imageSelected(value:Image?){
        //hier könnt ihr individuelle sachen machen nachdem ein bild gewählt wurde
        dc.responseStr = ""
        filenameTxt = Svars.currentFilename
    }
    
}

struct UploadForm2_Previews: PreviewProvider {
    static var previews: some View {
        UploadForm2()
    }
}
