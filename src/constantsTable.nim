# Credits to https://github.com/SciNim/nim-constants for 162 of the constants
import tables
import macros
import strutils

const
  accelerationOfGravity*: float64 = 9.80665
  alladiGrinstead*: float64 = 0.80939402054063913071
  apery*: float64 = 1.20205690315959428539973816
  areaOfFordCircle*: float64 = 0.87228404106562797617
  artin*: float64 = 0.37395581361920228805
  astronomicalUnit*: float64 = 1.49597871e+11
  atomicMass*: float64 = 1.66053904e-27
  backhouse*: float64 = 1.45607494858268967139959535
  baker*: float64 = 0.83564884826472105333
  baxterFourColoring*: float64 = 1.46099848620631835815
  bernstein*: float64 = 0.28016949902386913303
  blochLandau*: float64 = 0.54325896534297670695
  bohrMagneton*: float64 = 9.27400999e-24
  bohrRadius*: float64 = 5.29177211e-11
  boisReymond*: float64 = 0.19452804946532511361
  bolometricLuminosity*: float64 = 3.0128e+28
  boltzmann*: float64 = 1.38064852e-23
  bronzeRatio*: float64 = 3.30277563773199464655
  brun*: float64 = 0.87058838
  buffon*: float64 = 0.63661977236758134307
  cahen*: float64 = 0.6434105462
  calabiTriangle*: float64 = 1.55138752454832039226
  carefree*: float64 = 0.70444220099916559273
  carlsonLevin*: float64 = 1.77245385090551602729
  catalan*: float64 = 0.91596559417721901505460351
  champernowne*: float64 = 0.12345678910111213141
  chebyshev*: float64 = 0.59017029950804811302
  conicSchwarzschild*: float64 = 7.38905609893065022723
  connective*: float64 = 1.84775906502257351225
  conway*: float64 = 1.30357726903429639125709911
  copelandErdos*: float64 = 0.23571113171923293137
  cubicRecurrence*: float64 = 1.15636268433226971685
  deVicciTesseract*: float64 = 1.00743475688427937609
  delian*: float64 = 1.25992104989487316477
  dottie*: float64 = 0.73908513321516064165
  doubleFactorial*: float64 = 3.05940740534257614453
  earthEquatorialRadius*: float64 = 6378100.0
  earthMass*: float64 = 3.986004e+14
  earthsRotationalPeriod*: float64 = 23.96
  electronCharge*: float64 = 1.60217662e-19
  electronMass*: float64 = 9.10938356e-31
  embreeTrefethen*: float64 = 0.70258
  erdosBorwein*: float64 = 1.60669515241529176378330152
  euler*: float64 = 2.71828182845904523536
  eulerGompertz*: float64 = 0.59634736232319407434
  eulerMascheroni*: float64 = 0.57721566490153286060651209
  eulerTotient*: float64 = 1.94359643682075920505
  faraday*: float64 = 9.64870e4
  favard*: float64 = 1.57079632679489661923
  feigenbaumBifurcationVelocity*: float64 = 4.6692016091029906718532038
  feigenbaumReductionParameter*: float64 = 2.50290787509589282228390287
  fellerTornier*: float64 = 0.66131704946962233528
  fibonacciFactorial*: float64 = 1.22674201072035324441
  fineStructure*: float64 = 0.00729735257
  flajoletRichmond*: float64 = 0.28878809508660242127
  foiasAlpha*: float64 = 1.18745235112650105459
  foiasBeta*: float64 = 2.29316628741186103150
  fransenRobinson*: float64 = 2.80777024202851936522150118
  gas*: float64 = 8.3144598
  gauss*: float64 = 0.83462684167407318628
  gaussianGravitational*: float64 = 0.01720209895
  gaussKuzminWirsing*: float64 = 0.30366300289873265859744812
  gaussLemniscate*: float64 = 1.85407467730137191843
  gelfond*: float64 = 23.1406926327792690057
  gelfondSchneider*: float64 = 2.66514414269022518865
  gibbs*: float64 = 1.85193705198246617036
  gieseking*: float64 = 1.01494160640965362502
  glaisherKinkelin*: float64 = 1.28242712910062263687
  gohSchmutz*: float64 = 1.11786415118994497314
  goldenAngle*: float64 = 2.39996322972865332223
  goldenRatio*: float64 = 1.61803398874989484820
  goldenSpiral*: float64 = 1.35845627418298843520
  golombDickman*: float64 = 0.62432998854355087099293638
  gravitational*: float64 = 6.67408e-11
  grothendieck*: float64 = 1.78221397819136911177
  hafnerSarnakMcCurley*: float64 = 0.35323637185499598454351655
  hallMontgomery*: float64 = 0.17150049314153606586
  heathBrownMoroz*: float64 = 0.00131764115485317810
  hermite*: float64 = 0.74048048969306104116
  hyperbolicTangent*: float64 = 0.76159415595576488811
  inversePi*: float64 = 0.31830988618379067153
  ioachimescu*: float64 = 0.53964549119041318711
  josephson*: float64 = 483597.898e9
  jupiterEquatorialRadius*: float64 = 71492000.0
  jupiterMass*: float64 = 1.2668653e+17
  kasner*: float64 = 1.75793275661800453270
  kempnerReihe*: float64 = 23.1034479094205416160
  keplerBouwkamp*: float64 = 0.11494204485329620070
  khinchin*: float64 = 2.68545200106530644530971483
  khinchinLevy*: float64 = 1.18656911041562545282
  kiloparsec*: float64 = 3.08567758e+19
  kneserMahler*: float64 = 1.38135644451849779337
  komornikLoreti*: float64 = 1.78723165018296593301
  landauRamanujan*: float64 = 0.76422365358922066299069873
  laplaceLimit*: float64 = 0.66274341934918158097474209
  lebesgue*: float64 = 1.43599112417691743235
  lebesqueLTwo*: float64 = 1.64218843522212113687
  lemniscate*: float64 = 2.62205755429211981046
  levy*: float64 = 3.27582291872181115978768188
  liebsSquareIce*: float64 = 1.5396007178
  liouville*: float64 = 0.110001000000000000000001
  loch*: float64 = 0.97027011439203392574
  luroth*: float64 = 0.78853056591150896106
  madelung*: float64 = 5.97798681217834912266
  magicAngle*: float64 = 0.955316618124509278163
  magneticVacuumPermeability*: float64 = 1.25663706e-06
  masserGramain*: float64 = 6.58088599101792097085
  meisselMertens*: float64 = 0.26149721284764278375542683
  mill*: float64 = 1.30637788386308069046861449
  minXPowX*: float64 = 0.69220062755534635386
  mKB*: float64 = 0.07077603931152880353
  mRB*: float64 = 0.18785964246206712024
  murata*: float64 = 2.82641999706759157554
  neutronMass*: float64 = 1.67492747e-27
  nielsenRamanujan*: float64 = 0.82246703342411321823
  niven*: float64 = 1.70521114010536776428855145
  omega*: float64 = 0.56714329040978387299996866
  orbitalPeriodOfEarth*: float64 = 365.24219879
  paris*: float64 = 1.09864196439415648573
  parsec*: float64 = 3.08567758e+16
  pell*: float64 = 0.58057755820489240229
  pi*: float64 = 3.14159265358979323846
  piSquared*: float64 = 9.8696044010893586188
  planck*: float64 = 6.62607004e-34
  plastic*: float64 = 1.32471795724474602596090885
  plouffe*: float64 = 0.15915494309189533576
  plouffeGamma*: float64 = 0.14758361765043327417
  polya*: float64 = 0.34053732955099914282
  porter*: float64 = 1.4670780794
  protonMass*: float64 = 1.6726219e-27
  prouhetThueMorse*: float64 = 0.41245403364010759778
  pythagoras*: float64 = 1.41421356237309504880
  raabe*: float64 = 0.91893853320467274178
  ramanujanSoldner*: float64 = 1.45136923488338105028396848
  reciprocalFibonacci*: float64 = 3.35988566624317755317201130
  reducedPlanck*: float64 = 1.0545718e-34
  renyiParking*: float64 = 0.74759792025341143517
  reuleauxTriangle*: float64 = 0.98770039073605346013
  riemannZeta*: float64 = 1.64493406684822643647
  robbins*: float64 = 0.66170718226717623515
  rutgers*: float64 = 3.16227766016837933200
  rydberg*: float64 = 10973731.6
  sarnak*: float64 = 0.72364840229820000940
  sierpinski*: float64 = 2.58498175957925321706589358
  silverman*: float64 = 1.78657645936592246345
  smarandache*: float64 = 1.09317045919549089396
  solarLuminosity*: float64 = 3.828e+26
  somosQuadraticRecurrence*: float64 = 1.66168794963359412129
  sophomoreDream*: float64 = 0.78343051071213440705
  sophomoreDreamLTwo*: float64 = 1.29128599706266354040
  speedOfLight*: float64 = 299792458.0
  spiralOfTheodorus*: float64 = 1.86002507922119030718
  stefanBoltzmann*: float64 = 5.670367e-08
  steiner*: float64 = 1.44466786100976613365
  stephens*: float64 = 0.57595996889294543964
  stronglyCarefree*: float64 = 0.28674742843447873410
  sunEquatorialRadius*: float64 = 695700000.0
  sunMass*: float64 = 1.3271244e+20
  taniguchi*: float64 = 0.67823449191739197803
  tau*: float64 = 6.28318530717958647693
  theodorus*: float64 = 1.73205080756887729352
  thomsonScatteringCrossSection*: float64 = 6.65245872e-29
  tribonacci*: float64 = 1.83928675521416113255
  trott*: float64 = 0.10841015122311136151
  tutteBeraha*: float64 = 3.24697960371746706105
  twinPrime*: float64 = 0.66016181584686957392781211
  universalParabolic*: float64 = 2.29558714939263807403429804
  vacuumElectricPermittivity*: float64 = 8.85418782e-12
  vanDerPauw*: float64 = 4.53236014182719380962
  vardi*: float64 = 1.26408473530530111307
  viswanath*: float64 = 1.13198824
  volumeOfReuleauxTetrahedron*: float64 = 0.42215773311582662702
  wallis*: float64 = 2.09455148154232659148
  weierstrass*: float64 = 0.47494937998792065033
  wienWavelengthDisplacementLaw*: float64 = 0.0028977729
  wright*: float64 = 1.9287800

macro autoPopulateConstants(symbols: varargs[untyped]): untyped =
  result = newNimNode(nnkTableConstr)

  for sym in symbols:
    let camelName: string = sym.toStrLit.strVal # e.g. "accelerationOfGravity"
    var snakeName: string = "" # e.g. "acceleration_of_gravity"

    for c in camelName:
      if c.isUpperAscii:
        snakeName.add('_')
        snakeName.add(c.toLowerAscii)
      else:
        snakeName.add(c)

    # 1. Add the original name (camelCase)
    let keyCamel = newLit(camelName)
    result.add newTree(nnkExprColonExpr, keyCamel, sym)

    # 2. Add the generated snake_case name (if it's different)
    if snakeName != camelName:
      let keySnake = newLit(snakeName)
      result.add newTree(nnkExprColonExpr, keySnake, sym)

let Constants*: Table[string, float64] = autoPopulateConstants(
  accelerationOfGravity, alladiGrinstead, apery, areaOfFordCircle, artin,
  astronomicalUnit, atomicMass, backhouse, baker, baxterFourColoring, bernstein,
  blochLandau, bohrMagneton, bohrRadius, boisReymond, bolometricLuminosity, boltzmann,
  bronzeRatio, brun, buffon, cahen, calabiTriangle, carefree, carlsonLevin, catalan,
  champernowne, chebyshev, conicSchwarzschild, connective, conway, copelandErdos,
  cubicRecurrence, delian, deVicciTesseract, dottie, doubleFactorial,
  earthEquatorialRadius, earthMass, earthsRotationalPeriod, electronCharge,
  electronMass, embreeTrefethen, erdosBorwein, euler, eulerGompertz, eulerMascheroni,
  eulerTotient, faraday, favard, feigenbaumBifurcationVelocity,
  feigenbaumReductionParameter, fellerTornier, fibonacciFactorial, fineStructure,
  flajoletRichmond, foiasAlpha, foiasBeta, fransenRobinson, gas, gauss,
  gaussianGravitational, gaussKuzminWirsing, gaussLemniscate, gelfond, gelfondSchneider,
  gibbs, gieseking, glaisherKinkelin, gohSchmutz, goldenAngle, goldenRatio,
  goldenSpiral, golombDickman, gravitational, grothendieck, hafnerSarnakMcCurley,
  hallMontgomery, heathBrownMoroz, hermite, hyperbolicTangent, inversePi, ioachimescu,
  josephson, jupiterEquatorialRadius, jupiterMass, kasner, kempnerReihe, keplerBouwkamp,
  khinchin, khinchinLevy, kiloparsec, kneserMahler, komornikLoreti, landauRamanujan,
  laplaceLimit, lebesgue, lebesqueLTwo, lemniscate, levy, liebsSquareIce, liouville,
  loch, luroth, madelung, magicAngle, magneticVacuumPermeability, masserGramain,
  meisselMertens, mill, minXPowX, mKB, mRB, murata, neutronMass, nielsenRamanujan,
  niven, omega, orbitalPeriodOfEarth, paris, parsec, pell, pi, piSquared, planck,
  plastic, plouffe, plouffeGamma, polya, porter, protonMass, prouhetThueMorse,
  pythagoras, raabe, ramanujanSoldner, reciprocalFibonacci, reducedPlanck, renyiParking,
  reuleauxTriangle, riemannZeta, robbins, rutgers, rydberg, sarnak, sierpinski,
  silverman, smarandache, solarLuminosity, somosQuadraticRecurrence, sophomoreDream,
  sophomoreDreamLTwo, speedOfLight, spiralOfTheodorus, stefanBoltzmann, steiner,
  stephens, stronglyCarefree, sunEquatorialRadius, sunMass, taniguchi, tau, theodorus,
  thomsonScatteringCrossSection, tribonacci, trott, tutteBeraha, twinPrime,
  universalParabolic, vacuumElectricPermittivity, vanDerPauw, vardi, viswanath,
  volumeOfReuleauxTetrahedron, wallis, weierstrass, wienWavelengthDisplacementLaw,
  wright,
).toTable
