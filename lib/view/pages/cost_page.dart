part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  HomeViewmodel homeViewmodel = HomeViewmodel();

  @override
  void initState() {
    homeViewmodel.getProvinceList();
    super.initState();
  }

  Province? selectedProvince1;
  City? selectedCity1;
  Province? selectedProvince2;
  City? selectedCity2;
  dynamic selectedCourier = "jne";
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Hitung Ongkir", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewmodel>(
        create: (BuildContext context) => homeViewmodel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Consumer<HomeViewmodel>(
                          builder: (context, value, _) {
                            switch (value.provinceList.status) {
                              case Status.loading:
                                return Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                );
                              case Status.completed:
                                return Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedCourier,
                                      items: ['jne', 'pos', 'tiki'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCourier = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              default:
                                return Container();
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Consumer<HomeViewmodel>(
                          builder: (context, value, _) {
                            switch (value.provinceList.status) {
                              case Status.loading:
                                return Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                );
                              case Status.completed:
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: TextField(
                                    controller: weightController,
                                    decoration: InputDecoration(
                                      labelText: 'Berat (gr)',
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                );
                              default:
                                return Container();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Pilih provinsi dan kota asal
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Origin", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 20
                      )
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Consumer<HomeViewmodel>(
                            builder: (context, value, _) {
                              switch (value.provinceList.status) {
                                case Status.loading:
                                  return Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  );
                                case Status.error:
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Text(value.provinceList.message.toString()),
                                  );
                                case Status.completed:
                                  return DropdownButton(
                                    isExpanded: true,
                                    value: selectedProvince1,
                                    hint: Text('Pilih provinsi asal'),
                                    items: value.provinceList.data?.map((Province value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.province.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedProvince1 = newValue!;
                                        selectedCity1 = null;
                                        homeViewmodel.getCityList(selectedProvince1?.provinceId);
                                      });
                                    },
                                  );
                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Consumer<HomeViewmodel>(
                            builder: (context, value, _) {
                              switch (value.cityList.status) {
                                case Status.loading:
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Pilih provinsi dulu"),
                                  );
                                case Status.error:
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Text(value.cityList.message.toString()),
                                  );
                                case Status.completed:
                                  return DropdownButton(
                                    isExpanded: true,
                                    value: selectedCity1,
                                    hint: Text('Pilih kota asal'),
                                    items: value.cityList.data?.map((City value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.cityName.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCity1 = newValue!;
                                      });
                                    },
                                  );
                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Pilih provinsi dan kota tujuan
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Destination", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 20
                      )
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Consumer<HomeViewmodel>(
                            builder: (context, value, _) {
                              switch (value.provinceList.status) {
                                case Status.loading:
                                  return Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  );
                                case Status.error:
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Text(value.provinceList.message.toString()),
                                  );
                                case Status.completed:
                                  return DropdownButton(
                                    isExpanded: true,
                                    value: selectedProvince2,
                                    hint: Text('Pilih provinsi tujuan'),
                                    items: value.provinceList.data?.map((Province value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.province.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedProvince2 = newValue;
                                        selectedCity2 = null;
                                        homeViewmodel.getCityList2(selectedProvince2?.provinceId);
                                      });
                                    },
                                  );
                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Consumer<HomeViewmodel>(
                            builder: (context, value, _) {
                              switch (value.cityList2.status) {
                                case Status.loading:
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Pilih provinsi dulu"),
                                  );
                                case Status.error:
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Text(value.cityList2.message.toString()),
                                  );
                                case Status.completed:
                                  return DropdownButton(
                                    isExpanded: true,
                                    value: selectedCity2,
                                    hint: Text('Pilih kota tujuan'),
                                    items: value.cityList2.data?.map((City value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value.cityName.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCity2 = newValue;
                                      });
                                    },
                                  );
                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    homeViewmodel.getShippingCosts(
                      origin: selectedCity1!.cityId,
                      destination: selectedCity2!.cityId,
                      weight: int.parse(weightController.text),
                      courier: selectedCourier,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 16),
                    minimumSize: Size(150, 60)
                  ),
                  child: Text('Hitung Estimasi Harga', style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: 16),
                Consumer<HomeViewmodel>(
                  builder: (context, value, _) {
                    switch (value.shippingCosts.status) {
                      case Status.loading:
                        return Center(child: CircularProgressIndicator());
                      case Status.error:
                        return Center(child: Text(value.shippingCosts.message.toString()));
                      case Status.completed:
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.shippingCosts.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final costs = value.shippingCosts.data![index];
                            return Card(
                              elevation: 8.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(
                                        _getServiceName(costs.service!),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Biaya: Rp${costs.cost![0].value.toString()}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Estimasi sampai: ${costs.cost![0].etd.toString()}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colors.green 
                                            ),
                                          ),
                                        ],
                                      ),
                                      leading: 
                                        IconButton(onPressed: () {}, icon: Icon(Icons.paid_outlined, color: Colors.black, size: 45)),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      default:
                        return Center(child: Text('Tidak ada data.'));
                    }
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _getServiceName(String service) {
  switch (service) {
    case 'ECO': 
      return 'Economy Service (ECO)'; 
    case 'REG': 
      return 'Regular Service (REG)'; 
    case 'ONS': 
      return 'Over Night Service (ONS)'; 
    default: 
      return service;
  }
}
