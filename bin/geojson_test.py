from geojson import Feature, MultiLineString

ms = MultiLineString(
    [
        [
            (40.62407511427595, -111.75203183313631),
            (40.62418097530738, -111.75179579876064),
            (40.62432755184311, -111.75138273860323),
            (40.624323480277, -111.75119498398621),
            (40.62429497930739, -111.75102332262209),
            (40.62424204890301, -111.75081411033456),
            (40.62414025954591, -111.75066927105858),
            (40.623981467839066, -111.75055661828839),
            (40.62390817923166, -111.75052979620024),
            (40.623757530175, -111.75051370294734),
        ]
    ]
)

f = Feature(geometry=ms, properties={"type": "curve", "speed_mph": 25, "lanes": 1,})

print(f)