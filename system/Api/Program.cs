using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories;
using DataAccess.EFCore.Repositories.GenericRepo;
using DataAccess.EFCore.Repositories.UnitOfWorkRepo;
using Domain.Interfaces;
using Domain.Interfaces.IGenericRepo;
using Domain.Interfaces.IUnitOfWork;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

if(connectionString != null)
{
    builder.Services.AddDbContext<ApplicationDbContext>(option => 
    option.UseSqlServer(connectionString));
}

builder.Services.AddTransient(typeof(IGenericRepository<>), typeof(GenericRepository<>));
builder.Services.AddTransient<IUnitOfWork, UnitOfWork>();
builder.Services.AddTransient<ICaThiRepository, CaThiRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
