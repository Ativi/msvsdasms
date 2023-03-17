# WEEK 5 AI's

## OpenFASoC Flow For RingOscillator and OneBitADC

1. Setup:- 
- Install directory ```~/openfasoc/openfasoc/generators```
- Create new folder with your design name.

![image](https://user-images.githubusercontent.com/68071764/226056226-a266d1c4-0c95-4c45-8f23-61ebbfb29357.png)

- Below folders required for flow

![image](https://user-images.githubusercontent.com/68071764/226056439-4b048689-910f-45ca-9953-3b6a0a6f2688.png)

- Note1. - Your folder name should be common as it will be used for your whole design to run.
- Note2. - Your folder name and .py name should be same.
- Note3. - Analyse your verilog file properly(VDD,IN,OUT) as per your design, else it may lead to n number of errors.
- Note4. - Most of the errors will be due to space or Path, can be cleared patiently.


- Go to ```your folder/src/``` and place your dummy verilog code.

![image](https://user-images.githubusercontent.com/68071764/226057757-51d38a3c-af00-4989-a21c-6b34ce1a8ea6.png)

- Contents of the /tools/ Directory

![image](https://user-images.githubusercontent.com/68071764/226057906-15041a06-f995-4f2d-b551-5e928a23c687.png)

2. Verilog Generation:-

- Open the terminal in the your folder name -gen directory and do make sky130hd_verilog to generate the Verilog files.

![image](https://user-images.githubusercontent.com/68071764/226058221-cccd2789-031f-41b5-9577-7c610703a602.png)

![image](https://user-images.githubusercontent.com/68071764/226058423-f17005ad-64e9-45ff-8d9b-3d6ffe2d8e7c.png)

![verilog_generated](https://user-images.githubusercontent.com/68071764/226058498-a50f01cd-fcfd-4bea-b1e0-fa3a15d8719f.png)


- The Generated verilog files reside in the /your folder name -gen/flow/design/src/ folder.

3.  Synthesis to PNR flow:- 

- Run the command make sky130hd_build to run the verilog generation, Synthesis, Place and Route.

![image](https://user-images.githubusercontent.com/68071764/226058832-acba6002-be87-4fc1-b6d7-13ec512f800b.png)

Verilog Generated:

![verilog_done](https://user-images.githubusercontent.com/68071764/226059211-ab58f234-5d60-4e45-9413-e98dcbfb6066.png)

![image](https://user-images.githubusercontent.com/68071764/226059087-44a8b325-3fbe-4951-b1fd-0ef634f1ee3a.png)

- Running Flooorplan:

![image](https://user-images.githubusercontent.com/68071764/226059575-626b7c87-9f40-45de-af5f-211f0ba90ab9.png)

- Floorplan Power Report:

![image](https://user-images.githubusercontent.com/68071764/226059644-6a6e88df-be34-4c66-9d65-f080ec5fe27c.png)

- Running Placement:

![image](https://user-images.githubusercontent.com/68071764/226059872-d1c3e6ab-7621-4494-9f04-927740f730ad.png)

- Global place report

![image](https://user-images.githubusercontent.com/68071764/226059972-5c103e9c-440d-4a62-b385-b40276146106.png)

- Placement Analysis Report:

![image](https://user-images.githubusercontent.com/68071764/226060014-d54ec642-8364-421d-80ae-bed5ddb4ef4e.png)

- Run Routing: 

![image](https://user-images.githubusercontent.com/68071764/226060135-ca4b2a9c-1a49-48f1-9228-17cf12321ce5.png)

- Routing Resource Analysis

![image](https://user-images.githubusercontent.com/68071764/226060226-dd43f11d-99ed-4b27-8b4b-38a9bd2f7b94.png)

-Final Congestion Report:

![image](https://user-images.githubusercontent.com/68071764/226060306-b95c4730-af01-41dd-aa6d-59390c5a2068.png)

- Optimization Iterations in Routing:

![image](https://user-images.githubusercontent.com/68071764/226060395-16f79ece-21ec-4546-a3e3-1e7149a0611c.png)

![image](https://user-images.githubusercontent.com/68071764/226060510-2b0bfd7f-8e92-47e2-bbab-70aa810d8219.png)

![image](https://user-images.githubusercontent.com/68071764/226060555-201a2545-60b3-4109-8898-7020c6118a8b.png)


![image](https://user-images.githubusercontent.com/68071764/226060650-ee251ca1-0db6-4988-9d61-286066485581.png)

- Completed Detail routing:

![image](https://user-images.githubusercontent.com/68071764/226060714-15f102ea-7231-46b1-9704-a0b57082e4ff.png)

- Results folder:
![image](https://user-images.githubusercontent.com/68071764/226061019-2a964689-1308-4ecb-ba1c-2092ea14a8c4.png)

## Getting Errors and warnings

![image](https://user-images.githubusercontent.com/68071764/226060879-ae4b759e-a894-4cc7-acc6-f391741db275.png)

![image](https://user-images.githubusercontent.com/68071764/226060918-cea7067a-acfc-42de-81c4-fdffcddcdc80.png)

# Work In progress







