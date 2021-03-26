from __future__ import print_function
from rdkit import Chem
from rdkit.Chem import AllChem
import rdkit
from rdkit.Chem import Draw
import os
import sys
import subprocess
import numpy as np
from csv import DictReader
from pybel import *

def inchi_to_dft(InChI_key, InChIes):
    dd = dict(zip(InChI_key, InChIes))
    for key, value in dd.items():
        if  Chem.MolFromSmiles(value) is not None:
            print(key, value)
            m4 = Chem.MolFromSmiles(value)
            AllChem.Compute2DCoords(m4)
            m5 = Chem.AddHs(m4)
            if AllChem.EmbedMolecule(m5, useRandomCoords=True) == -1:
                pass #print(AllChem.EmbedMolecule(m5, useRandomCoords=True))
            else:
                AllChem.EmbedMolecule(m5, useRandomCoords=True)
                AllChem.MMFFOptimizeMolecule(m5)

                rdkit.Chem.rdmolfiles.MolToPDBFile(m5, str(key) + '.pdb')
                file_mol = open(str(key)+".mol", 'w')
                file_mol.write(Chem.MolToMolBlock(m5))
        
                ii = Chem.MolToMolBlock(m5).splitlines()
                f=open(str(key)+".xyz", 'w')
                natom = m5.GetNumAtoms()
                f.write(str(m5.GetNumAtoms()) + '\n')
                f.write('covid\n')
                for i in range(4, 4+m5.GetNumAtoms()):
                    jj=' '.join((ii[i].split()))
                    kk=jj.split()
                    f.write("{}\t{:>8}  {:>8}  {:>8}\n".format(kk[3], kk[0], kk[1], kk[2]))
                f.close()




# Reads InChI and InChI-key from .csv file
InChI_key = []
InChIes     = []

with open("input.csv") as f:
     for lines in f.readlines():
         line = lines.split(',')
         InChI_key.append(line[0])
         InChIes.append(line[1].rstrip())

os.system('mkdir data_files')
os.system('mkdir ligands')

os.chdir('data_files')

os.system('mkdir pdb_files')
os.system('mkdir xyz_files')
os.system('mkdir mol2_files')

inchi_to_dft(InChI_key, InChIes)

xyz = [i.rstrip() for i in os.listdir('.') if i.endswith('.xyz')]
pdb = [i.rstrip() for i in os.listdir('.') if i.endswith('.pdb')]
mol_file = [i.rstrip() for i in os.listdir('.') if i.endswith('.mol')]  

# moves .xyz and .pdb files
for each in xyz:
    os.system('mv {} {}'.format(each, 'xyz_files'))

for each in pdb:
    os.system('mv {} {}'.format(each, 'pdb_files'))

for each in mol_file:
    os.system('mv {} {}'.format(each, 'mol2_files'))
    
os.chdir('mol2_files')
mof = [i.rstrip() for i in os.listdir('.') if i.endswith('.mol')]

for each in mof:
    mol11 = each.split('.')[0]+'.mol2'
    pdbqt = each.split('.')[0]+'.pdbqt'
    mol22 = readfile('mol', each).__next__()
    output = Outputfile('mol2', mol11)
    output.write(mol22)
    title=each.split('.')[0]
#    os.system('obabel -i mol2 {} -o pdbqt -O {} -xh'.format(mol11, pdbqt))
    os.system('obabel -i mol2 {} --addtotitle {} -o pdbqt -O {}'.format(mol11,title, pdbqt))
    os.system('mv {} {}'.format('*.pdbqt', '../../ligands'))
    os.system('rm {}'.format(each))

os.chdir('../')
os.chdir('../')


